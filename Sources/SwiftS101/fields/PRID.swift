//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct PRID: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let rver: Int
    public let ruin: Int
    
    static func create(_ node: FieldNode) -> PRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let rver = node.valueByLabel["RVER"] as? Int else {
            return nil
        }
        guard let ruin = node.valueByLabel["RUIN"] as? Int else {
            return nil
        }
        
        return PRID(recordIdentifier: recordIdentifier, rver: rver, ruin: ruin)
    }

    
}
