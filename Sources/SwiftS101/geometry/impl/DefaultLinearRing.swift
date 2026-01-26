//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultLinearRing: LinearRing {
    
    public let coordinates: [Coordinate]
    
    public func isEmpty() -> Bool {
        return coordinates.isEmpty
    }
    
    public func isValid() -> Bool {
        if coordinates.count < 3 {
            return false
        }
        return coordinates.first!.isEqual(to: coordinates.last!)
    }
    
    public func bbox() -> BoundingBox? {
        return DefaultBoundingBox.create(coordinates)
    }
    
    public func transform(_ transform: (Coordinate) -> Coordinate) -> DefaultLinearRing {
        var newCoords: [Coordinate] = []
        for coord in coordinates {
            newCoords.append(transform(coord))
        }
        return DefaultLinearRing(coordinates: newCoords)
    }

}
