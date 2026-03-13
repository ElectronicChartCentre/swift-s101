//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public protocol GeometryRecord: RecordWithINAS {
    
    func createGeometry(dsf: DataSetFile, creator: GeometryCreator) -> Geometry
    
    func createGeometry(dsf: DataSetFile, creator: GeometryCreator, forward: Bool) -> Geometry
    
    func spatialType() -> String
    
    var inass: [INAS] { get }
    
}
