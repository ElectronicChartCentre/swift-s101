//
//  File.swift
//  swift-s101
//

import Foundation

public protocol Geometry {
    
    func isEmpty() -> Bool
    
    func isValid() -> Bool
    
    func bbox() -> BoundingBox?
    
    func transform(_ transform: (Coordinate) -> Coordinate) -> Self
    
}
