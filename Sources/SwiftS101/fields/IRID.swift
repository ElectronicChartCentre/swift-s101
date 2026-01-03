//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct IRID: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let nitc: Int
    public let rver: Int
    public let ruin: Int
    
    static func create(_ node: FieldNode) -> IRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let nitc = node.valueByLabel["NITC"] as? Int else {
            return nil
        }
        guard let rver = node.valueByLabel["RVER"] as? Int else {
            return nil
        }
        guard let ruin = node.valueByLabel["RUIN"] as? Int else {
            return nil
        }
        
        return IRID(recordIdentifier: recordIdentifier, nitc: nitc, rver: rver, ruin: ruin)
    }

}
