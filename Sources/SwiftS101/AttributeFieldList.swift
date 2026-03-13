//
//  File.swift
//  swift-s101
//

import Foundation
import OrderedCollections

public struct AttributeFieldList: Sendable {

    public let rootNode: TreeNode
    
    func attrs() -> [ATTR] {
        var attrs = [ATTR]()
        rootNode.append(attrs: &attrs)
        return attrs
    }
    
    public struct TreeNode: Sendable {
        
        public let attr: ATTR?
        let childrenByAtcd: OrderedDictionary<String, [TreeNode]>
        
        public init(attr: ATTR?, childrenByAtcd: OrderedDictionary<String, [TreeNode]>) {
            self.attr = attr
            self.childrenByAtcd = childrenByAtcd
        }
        
        func append(attrs: inout [ATTR]) {
            if let attr = attr {
                attrs.append(attr)
            }
            for childs in childrenByAtcd.values {
                for child in childs {
                    child.append(attrs: &attrs)
                }
            }
        }
        
        public func children(atcd: String) -> [TreeNode] {
            return childrenByAtcd[atcd] ?? []
        }
        
    }
    
}

public class AttributeFieldListBuilder {
    
    private var nodeList: [TreeNodeBuilder] = []
    public let rootNode = TreeNodeBuilder()
    
    func add(attr: ATTR) -> ATTR {
        let parentNode = attr.paix > 0 ? nodeList[attr.paix - 1] : rootNode
        let attrNode = parentNode.addChild(attr: attr)
        nodeList.append(attrNode)
        return attr
    }
    
    func addAll(attrs: [ATTR]) {
        for attr in attrs {
            let _ = add(attr: attr)
        }
    }
    
    func attrs() -> [ATTR] {
        var attrs = [ATTR]()
        rootNode.append(attrs: &attrs)
        return attrs
    }
    
    func applyModify(updateAttrs: AttributeFieldListBuilder) {
        rootNode.applyModify(updateNode: updateAttrs.rootNode)
        rootNode.repairATIXs()
    }
    
    func build() -> AttributeFieldList {
        .init(rootNode: rootNode.build())
    }
    
    public class TreeNodeBuilder {
        
        let parent: TreeNodeBuilder?
        var _attr: ATTR?
        var childrenByAtcd: OrderedDictionary<String, [TreeNodeBuilder]> = [:]
        
        init() {
            self.parent = nil
            self._attr = nil
        }
        
        init(parent: TreeNodeBuilder?, attr: ATTR?) {
            self.parent = parent
            self._attr = attr
        }
        
        public func attr() -> ATTR? {
            return _attr
        }
        
        func append(attrs: inout [ATTR]) {
            if let attr = _attr {
                attrs.append(attr)
            }
            for childs in childrenByAtcd.values {
                for child in childs {
                    child.append(attrs: &attrs)
                }
            }
        }
                
        public func children(atcd: String) -> [TreeNodeBuilder] {
            return childrenByAtcd[atcd] ?? []
        }
        
        public func allChildren() -> [TreeNodeBuilder] {
            var allChildren: [TreeNodeBuilder] = []
            for children in childrenByAtcd.values {
                allChildren.append(contentsOf: children)
            }
            return allChildren
        }
        
        public func atcds() -> OrderedSet<String> {
            return childrenByAtcd.keys
        }
        
        func addChild(attr: ATTR) -> TreeNodeBuilder {
            let childNode = TreeNodeBuilder(parent: self, attr: attr)
            if var children = childrenByAtcd[attr.atcd] {
                if children.count >= (attr.atix - 1) {
                    children.insert(childNode, at: attr.atix - 1)
                } else {
                    children.append(childNode)
                }
                childrenByAtcd[attr.atcd] = children
            } else {
                childrenByAtcd[attr.atcd] = [childNode]
            }
            return childNode
        }
        
        func applyModify(updateNode: TreeNodeBuilder) {
            if let updateAttr = updateNode.attr() {
                if updateAttr.atin == ATTR.atinDelete {
                    if let parent, var parentChilds = parent.childrenByAtcd[updateAttr.atcd] {
                        parentChilds.removeAll { $0 === self }
                        parent.childrenByAtcd[updateAttr.atcd] = parentChilds
                    }
                    childrenByAtcd.removeAll()
                }
                
                if updateAttr.atin == ATTR.atinModify, let attr = attr() {
                    self._attr = ATTR(atcd: attr.atcd, atix: attr.atix, paix: attr.paix, atin: attr.atin, atvl: updateAttr.atvl)
                }
            }
            
            for (atcd, updateChildren) in updateNode.childrenByAtcd {
                for updateChild in updateChildren {
                    guard let updateChildAttr = updateChild.attr() else {
                        continue
                    }
                    
                    switch updateChildAttr.atin {
                    case ATTR.atinInsert:
                        insertChild(updateChild)
                    case ATTR.atinModify, ATTR.atinDelete:
                        // TODO: protect against array out of index exception
                        let baseChildren = children(atcd: atcd)
                        let baseChild = baseChildren[updateChildAttr.atix - 1]
                        baseChild.applyModify(updateNode: updateChild)
                    default:
                        break
                    }
                }
            }
        }
        
        func insertChild(_ childNodePrototype: TreeNodeBuilder) {
            guard let childNodePrototypeAttr = childNodePrototype.attr() else {
                return
            }
            
            let atcd = childNodePrototypeAttr.atcd
            let childNode = TreeNodeBuilder(parent: self, attr: childNodePrototypeAttr)
            
            var children = children(atcd: atcd)
            if children.count >= (childNodePrototypeAttr.atix - 1) {
                children.insert(childNode, at: childNodePrototypeAttr.atix - 1)
            } else {
                children.append(childNode)
            }
            childrenByAtcd[atcd] = children
            
            for childNodeChldPrototypes in childNodePrototype.childrenByAtcd.values {
                for childNodeChildPrototype in childNodeChldPrototypes {
                    childNode.insertChild(childNodeChildPrototype)
                }
            }
        }
        
        func repairATIXs() {
            for children in childrenByAtcd.values {
                for (i, child) in children.enumerated() {
                    let atix = i + 1
                    if let childAttr = child.attr(), childAttr.atix != atix {
                        child._attr = ATTR(atcd: childAttr.atcd, atix: atix, paix: childAttr.paix, atin: childAttr.atin, atvl: childAttr.atvl)
                    }
                    child.repairATIXs()
                }
            }
        }
        
        func build() -> AttributeFieldList.TreeNode {
            var cs: OrderedDictionary<String, [AttributeFieldList.TreeNode]> = [:]
            for (_, entry) in childrenByAtcd.enumerated() {
                var children: [AttributeFieldList.TreeNode] = []
                for childBuilder in entry.value {
                    children.append(childBuilder.build())
                }
                cs[entry.key] = children
            }
            return AttributeFieldList.TreeNode(attr: _attr, childrenByAtcd: cs)
        }
        
    }
    
}
