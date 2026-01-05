//
//  File.swift
//  swift-s101
//

import Foundation

public protocol GeometryCreator {
    
    func createCoordinate2D(xcoo: Int, ycoo: Int, x: Double, y: Double) -> Coordinate

    func createCoordinate3D(xcoo: Int, ycoo: Int, zcoo: Int, x: Double, y: Double, z: Double) -> Coordinate
    
    func createEmptyGeometry() -> Geometry
    
    func createPoint(coord: Coordinate) -> Geometry
    
    func createMultiPoint(coords: [Coordinate]) -> Geometry
    
    func createLineString(coords: [Coordinate]) -> Geometry
    
    func createLinearRing(coords: [Coordinate]) -> LinearRing
    
    func createPolygon(shell: LinearRing, holes: [LinearRing]) -> Geometry
    
    func createGeometry(geometries: [Geometry]) -> Geometry
    
}
