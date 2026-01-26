//
//  File.swift
//  swift-s101
//

import Foundation

public protocol Coordinate {
    
    var x: Double { get }
    
    var y: Double { get }
    
    func isEqual(to other: Coordinate) -> Bool
    
    func transform(newX: Double, newY: Double) -> Self
    
}
