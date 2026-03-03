//
//  File.swift
//  swift-s101
//

import Foundation

public protocol RecordWithVersion: Record {
    
    func recordVersion() -> RecordVersion
    
    func applyModify(update: RecordWithVersion) -> Self?
    
}
