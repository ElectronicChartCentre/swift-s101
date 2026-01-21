//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultBoundingBox: BoundingBox {
    
    public let minX: Double
    public let maxX: Double
    public let minY: Double
    public let maxY: Double
    
    static func create(_ coords: [Coordinate]) -> BoundingBox? {
        if coords.isEmpty {
            return nil
        }
        
        var minX: Double? = nil
        var maxX: Double? = nil
        var minY: Double? = nil
        var maxY: Double? = nil
        
        for c in coords {
            minX = min(minX ?? c.x, c.x)
            maxX = max(maxX ?? c.x, c.x)
            minY = min(minY ?? c.y, c.y)
            maxY = max(maxY ?? c.y, c.y)
        }
        
        if let minX, let maxX, let minY, let maxY {
            return DefaultBoundingBox(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
        }
        
        return nil
    }
    
}
