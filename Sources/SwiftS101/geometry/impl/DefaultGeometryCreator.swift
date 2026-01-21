//
//  File.swift
//  swift-s101
//

import Foundation

public struct DefaultGeometryCreator: GeometryCreator {
    
    public init() {
        
    }
    
    public func createCoordinate2D(xcoo: Int, ycoo: Int, x: Double, y: Double) -> any Coordinate {
        return DefaultCoordinate2D(x: x, y: y)
    }
    
    public func createCoordinate3D(xcoo: Int, ycoo: Int, zcoo: Int, x: Double, y: Double, z: Double) -> any Coordinate {
        return DefaultCoordinate3D(x: x, y: y, z: z)
    }
    
    public func createEmptyGeometry() -> any Geometry {
        return DefaultGeometry(coords: [])
    }
    
    public func createPoint(coord: any Coordinate) -> any Geometry {
        return DefaultGeometry(coords: [coord])
    }
    
    public func createMultiPoint(coords: [any Coordinate]) -> any Geometry {
        return DefaultGeometry(coords: coords)
    }
    
    public func createLineString(coords: [any Coordinate]) -> any Geometry {
        return DefaultGeometry(coords: coords)
    }
    
    public func createLinearRing(coords: [any Coordinate]) -> any LinearRing {
        return DefaultLinearRing(coords: coords)
    }
    
    public func createPolygon(shell: any LinearRing, holes: [any LinearRing]) -> any Geometry {
        return DefaultPolygon(shell: shell, holes: holes)
    }
    
    public func createGeometry(geometries: [any Geometry]) -> any Geometry {
        if geometries.isEmpty {
            return createEmptyGeometry()
        }
        if geometries.count == 1 {
            return geometries.first!
        }
        return DefaultMultiGeometry(geometries: geometries)
    }
    
}
