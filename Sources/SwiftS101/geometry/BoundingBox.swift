//
//  File.swift
//  swift-s101
//

import Foundation

public protocol BoundingBox {
    
    var minX: Double { get }
    
    var maxX: Double { get }

    var minY: Double { get }
    
    var maxY: Double { get }
    
}
