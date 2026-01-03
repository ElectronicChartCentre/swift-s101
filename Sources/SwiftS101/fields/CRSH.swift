//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct CRSH: Field {
    
    public let crix: Int
    public let crst: Int
    public let csty: Int
    public let crnm: String
    public let crsi: String
 
    static func create(_ node: FieldNode) -> CRSH? {
        
        guard let crix = node.valueByLabel["CRIX"] as? Int else {
            return nil
        }
        guard let crst = node.valueByLabel["CRST"] as? Int else {
            return nil
        }
        guard let csty = node.valueByLabel["CSTY"] as? Int else {
            return nil
        }
        guard let crnm = node.valueByLabel["CRNM"] as? String else {
            return nil
        }
        guard let crsi = node.valueByLabel["CRSI"] as? String else {
            return nil
        }
        
        return CRSH(crix: crix, crst: crst, csty: csty, crnm: crnm, crsi: crsi)
    }
    
}
