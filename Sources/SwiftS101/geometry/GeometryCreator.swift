//
//  File.swift
//  swift-s101
//

import Foundation

public protocol GeometryCreator {
    
    func createCoordinate2D(x: Double, y: Double, ref: Any) -> Coordinate

    func createCoordinate3D(x: Double, y: Double, z: Double, ref: Any) -> Coordinate
    
    func createEmptyGeometry() -> Geometry
    
    func createPoint(coord: Coordinate) -> Geometry
    
    func createMultiPoint(coords: [Coordinate]) -> Geometry
    
    func createLineString(coords: [Coordinate]) -> Geometry
    
    func createLinearRing(coords: [Coordinate]) -> LinearRing
    
    func createPolygon(shell: LinearRing, holes: [LinearRing]) -> Geometry
    
    func createGeometry(geometries: [Geometry]) -> Geometry
    
}
