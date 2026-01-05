//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct FRID: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let nftc: Int
    public let rver: Int
    public let ruin: Int
    
    static func create(_ node: FieldNode) -> FRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let nftc = node.valueByLabel["NFTC"] as? Int else {
            return nil
        }
        guard let rver = node.valueByLabel["RVER"] as? Int else {
            return nil
        }
        guard let ruin = node.valueByLabel["RUIN"] as? Int else {
            return nil
        }
        
        return FRID(recordIdentifier: recordIdentifier, nftc: nftc, rver: rver, ruin: ruin)
    }
    
}
