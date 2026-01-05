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
    
}
