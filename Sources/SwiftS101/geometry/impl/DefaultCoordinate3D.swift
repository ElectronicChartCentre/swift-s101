//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultCoordinate3D: Coordinate {
    
    public let x: Double
    public let y: Double
    public let z: Double
    
    public func isEqual(to other: Coordinate) -> Bool {
        if let other = other as? DefaultCoordinate3D {
            return x == other.x && y == other.y && z == other.z
        }
        return false
    }
    
}
