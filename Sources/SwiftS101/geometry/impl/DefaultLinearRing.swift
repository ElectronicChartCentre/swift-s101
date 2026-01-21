//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultLinearRing: LinearRing {
    
    public let coords: [Coordinate]
    
    public func isEmpty() -> Bool {
        return coords.isEmpty
    }
    
    public func isValid() -> Bool {
        if coords.count < 3 {
            return false
        }
        return coords.first!.isEqual(to: coords.last!)
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(coords)
    }

}
