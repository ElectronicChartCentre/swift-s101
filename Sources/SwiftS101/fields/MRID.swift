//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct MRID: Field {

    public let recordIdentifier: RecordIdentifier
    
    public let recordVersion: RecordVersion

    static func create(_ node: FieldNode) -> MRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let recordVersion = RecordVersion.create(node) else {
            return nil
        }

        return MRID(recordIdentifier: recordIdentifier, recordVersion: recordVersion)
    }

}
