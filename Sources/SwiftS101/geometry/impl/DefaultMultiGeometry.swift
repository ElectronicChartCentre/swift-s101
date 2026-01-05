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
    
}
