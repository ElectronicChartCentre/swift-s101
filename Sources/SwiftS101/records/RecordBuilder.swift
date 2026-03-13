//
//  File.swift
//  swift-s101
//

import Foundation

public protocol RecordBuilder {
    
    func recordIdentifier() -> RecordIdentifier
    
    func build() -> Record
    
}
