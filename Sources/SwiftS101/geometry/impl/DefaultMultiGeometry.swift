//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultMultiGeometry: MultiGeometry {
    
    public let geometries: [Geometry]
    
    public func isEmpty() -> Bool {
        for geometry in geometries {
            if !geometry.isEmpty() {
                return false
            }
        }
        return true
    }
    
    public func isValid() -> Bool {
        for geometry in geometries {
            if !geometry.isValid() {
                return false
            }
        }
        return true
    }
    
    public func bbox() -> BoundingBox? {
        var coords: [Coordinate] = []
        for geometry in geometries {
            if let bbox = geometry.bbox() {
                coords.append(DefaultCoordinate2D(x: bbox.minX, y: bbox.minY))
                coords.append(DefaultCoordinate2D(x: bbox.maxX, y: bbox.maxY))
            }
        }
        return DefaultBoundingBox.create(coords)
    }
    
}
