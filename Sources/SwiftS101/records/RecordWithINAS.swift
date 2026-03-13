//
//  File.swift
//  swift-s101
//

import Foundation

public protocol RecordWithINAS: Record {
    
    var inass: [INAS] { get }
    
}
