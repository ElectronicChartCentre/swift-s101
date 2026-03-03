//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct SRID: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let recordVersion: RecordVersion

    static func create(_ node: FieldNode) -> SRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let recordVersion = RecordVersion.create(node) else {
            return nil
        }

        return SRID(recordIdentifier: recordIdentifier, recordVersion: recordVersion)
    }
    
}
