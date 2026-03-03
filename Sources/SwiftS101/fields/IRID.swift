//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct IRID: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let nitc: Int

    public let recordVersion: RecordVersion

    static func create(_ node: FieldNode) -> IRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let nitc = node.valueByLabel["NITC"] as? Int else {
            return nil
        }
        guard let recordVersion = RecordVersion.create(node) else {
            return nil
        }

        return IRID(recordIdentifier: recordIdentifier, nitc: nitc, recordVersion: recordVersion)
    }

}
