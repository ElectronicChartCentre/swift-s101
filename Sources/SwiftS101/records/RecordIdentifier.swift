//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct RecordIdentifier: Hashable {
    
    public let rcnm: Int
    public let rcid: Int
    
    public init(rcnm: Int, rcid: Int) {
        self.rcnm = rcnm
        self.rcid = rcid
    }
    
    static func create(_ node: FieldNode) -> RecordIdentifier? {
        guard let rcnm = node.valueByLabel["RCNM"] as? Int else {
            return nil
        }
        guard let rcid = node.valueByLabel["RCID"] as? Int else {
            return nil
        }

        return RecordIdentifier(rcnm: rcnm, rcid: rcid)
    }
    
    static func createReferenced(_ node: FieldNode) -> RecordIdentifier? {
        
        // most have *RRNM, but INAS has RRNM without *
        var rcnm = node.valueByLabel["*RRNM"] as? Int
        if rcnm == nil {
            rcnm = node.valueByLabel["RRNM"] as? Int
        }
        guard let rcnm = rcnm else {
            return nil
        }
        guard let rcid = node.valueByLabel["RRID"] as? Int else {
            return nil
        }

        return RecordIdentifier(rcnm: rcnm, rcid: rcid)

    }
    
    private static func create(_ node: FieldNode, nameLabel: String, idLabel: String) -> RecordIdentifier? {
        
        guard let rcnm = node.valueByLabel[nameLabel] as? Int else {
            return nil
        }
        guard let rcid = node.valueByLabel[idLabel] as? Int else {
            return nil
        }

        return RecordIdentifier(rcnm: rcnm, rcid: rcid)
    }
    
}
