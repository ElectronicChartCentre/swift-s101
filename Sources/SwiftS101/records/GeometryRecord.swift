//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public protocol GeometryRecord: Record {
    
    func createGeometry(dsf: DataSetFile, creator: GeometryCreator) -> Geometry
    
    func createGeometry(dsf: DataSetFile, creator: GeometryCreator, forward: Bool) -> Geometry
    
    func spatialType() -> String
    
    func inass() -> [INAS]
    
}
