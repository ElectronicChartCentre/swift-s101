//
//  File.swift
//  swift-s101
//

import Foundation

public protocol MultiGeometry: Geometry {
    
    var geometries: [Geometry] { get }
    
}
