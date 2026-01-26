//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultPolygon: Geometry {
    
    public let shell: LinearRing
    public let holes: [LinearRing]
    
    public func isEmpty() -> Bool {
        return shell.isEmpty()
    }
    
    public func isValid() -> Bool {
        if !shell.isValid() { return false }
        for hole in holes {
            if !hole.isValid() { return false }
        }
        return true
    }
    
    public func bbox() -> BoundingBox? {
        return shell.bbox()
    }
    
    public func transform(_ transform: (Coordinate) -> Coordinate) -> DefaultPolygon {
        let newShell = shell.transform(transform)
        var newHoles: [LinearRing] = []
        for hole in newHoles {
            newHoles.append(hole.transform(transform))
        }
        return DefaultPolygon(shell: newShell, holes: newHoles)
    }
    
}
