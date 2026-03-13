//
//  File.swift
//  swift-s101
//

import Foundation

public protocol RecordBuilderWithVersion: RecordBuilder {
    
    func recordVersion() -> RecordVersion
    
    func applyModify(update: RecordBuilderWithVersion) -> Self?
    
}
