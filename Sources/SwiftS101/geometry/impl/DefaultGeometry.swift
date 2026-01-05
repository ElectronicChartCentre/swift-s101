//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultGeometry: Geometry {
    
    public let coords: [Coordinate]
    
    public func isEmpty() -> Bool {
        return coords.isEmpty
    }
    
}
