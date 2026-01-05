//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultCoordinate2D: Coordinate {
    
    public let x: Double
    public let y: Double

    public func isEqual(to other: Coordinate) -> Bool {
        if let other = other as? DefaultCoordinate2D {
            return x == other.x && y == other.y
        }
        return false
    }

}
