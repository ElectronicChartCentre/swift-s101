//
//  File.swift
//  swift-s101
//

import Foundation
import OrderedCollections

public class AttributeFieldList {
    
    private var nodeList: [TreeNode] = []
    public let rootNode = TreeNode()
    
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
    
    func applyModify(updateAttrs: AttributeFieldList) {
        rootNode.applyModify(updateNode: updateAttrs.rootNode)
        rootNode.repairATIXs()
    }
    
    public class TreeNode {
        
        let parent: TreeNode?
        public var attr: ATTR?
        var childrenByAtcd: OrderedDictionary<String, [TreeNode]> = [:]
        
        init() {
            self.parent = nil
            self.attr = nil
        }
        
        init(parent: TreeNode?, attr: ATTR?) {
            self.parent = parent
            self.attr = attr
        }
        
        func append(attrs: inout [ATTR]) {
            if let attr {
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
        
        public func allChildren() -> [TreeNode] {
            var allChildren: [TreeNode] = []
            for children in childrenByAtcd.values {
                allChildren.append(contentsOf: children)
            }
            return allChildren
        }
        
        public func atcds() -> OrderedSet<String> {
            return childrenByAtcd.keys
        }
        
        func addChild(attr: ATTR) -> TreeNode {
            let childNode = TreeNode(parent: self, attr: attr)
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
        
        func applyModify(updateNode: TreeNode) {
            if let updateAttr = updateNode.attr {
                if updateAttr.atin == ATTR.atinDelete {
                    if let parent, var parentChilds = parent.childrenByAtcd[updateAttr.atcd] {
                        parentChilds.removeAll { $0 === self }
                        parent.childrenByAtcd[updateAttr.atcd] = parentChilds
                    }
                    childrenByAtcd.removeAll()
                }
                
                if updateAttr.atin == ATTR.atinModify, let attr {
                    self.attr = ATTR(atcd: attr.atcd, atix: attr.atix, paix: attr.paix, atin: attr.atin, atvl: updateAttr.atvl)
                }
            }
            
            for (atcd, updateChildren) in updateNode.childrenByAtcd {
                for updateChild in updateChildren {
                    guard let updateChildAttr = updateChild.attr else {
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
        
        func insertChild(_ childNodePrototype: TreeNode) {
            guard let childNodePrototypeAttr = childNodePrototype.attr else {
                return
            }
            
            let atcd = childNodePrototypeAttr.atcd
            let childNode = TreeNode(parent: self, attr: childNodePrototypeAttr)
            
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
                    if let childAttr = child.attr, childAttr.atix != atix {
                        child.attr = ATTR(atcd: childAttr.atcd, atix: atix, paix: childAttr.paix, atin: childAttr.atin, atvl: childAttr.atvl)
                    }
                    child.repairATIXs()
                }
            }
        }
        
    }
    
}
