//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct RIAS: Field {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let ornt: Int
    public let usag: Int
    public let raui: Int

    static func create(_ node: FieldNode) -> RIAS? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let ornt = node.valueByLabel["ORNT"] as? Int else {
            return nil
        }
        guard let usag = node.valueByLabel["USAG"] as? Int else {
            return nil
        }
        guard let raui = node.valueByLabel["RAUI"] as? Int else {
            return nil
        }

        return RIAS(referencedRecordIdentifier: referencedRecordIdentifier, ornt: ornt, usag: usag, raui: raui)
    }
    
}
