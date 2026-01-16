//
//  File.swift
//  swift-s101
//

import Foundation
import OrderedCollections

public class AttributeFieldList {
    
    private var nodeList: [TreeNode] = []
    public let rootNode = TreeNode()
    
    func add(attr: ATTR) {
        let parentNode = attr.paix > 0 ? nodeList[attr.paix - 1] : rootNode
        let attrNode = parentNode.addChild(attr: attr)
        nodeList.append(attrNode)
    }
    
    public class TreeNode {
        
        let parent: TreeNode?
        public let attr: ATTR?
        var childrenByAtcd: OrderedDictionary<String, [TreeNode]> = [:]
        
        init() {
            self.parent = nil
            self.attr = nil
        }
        
        init(parent: TreeNode?, attr: ATTR?) {
            self.parent = parent
            self.attr = attr
        }
                
        public func children(atcd: String) -> [TreeNode] {
            return childrenByAtcd[atcd] ?? []
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
        
    }
    
}
