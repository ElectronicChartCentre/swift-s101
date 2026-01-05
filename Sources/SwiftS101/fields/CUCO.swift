//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct CUCO: Field {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let ornt: Int
    
    public static let orntForvard = 1
    public static let orntReverse = 2

    static func create(_ node: FieldNode) -> CUCO? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let ornt = node.valueByLabel["ORNT"] as? Int else {
            return nil
        }

        return CUCO(referencedRecordIdentifier: referencedRecordIdentifier, ornt: ornt)
    }
    
}
