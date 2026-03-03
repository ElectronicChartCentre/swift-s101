//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct PRID: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let recordVersion: RecordVersion

    static func create(_ node: FieldNode) -> PRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let recordVersion = RecordVersion.create(node) else {
            return nil
        }

        return PRID(recordIdentifier: recordIdentifier, recordVersion: recordVersion)
    }
    
}
