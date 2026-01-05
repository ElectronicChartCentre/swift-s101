//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct PTAS: Field {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let topi: Int
    
    static func create(_ node: FieldNode) -> PTAS? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let topi = node.valueByLabel["TOPI"] as? Int else {
            return nil
        }

        return PTAS(referencedRecordIdentifier: referencedRecordIdentifier, topi: topi)
    }
    
}
