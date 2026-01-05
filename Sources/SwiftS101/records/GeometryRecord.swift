//
//  File.swift
//  swift-s101
//

import Foundation

public protocol GeometryRecord: Record {
    
    func createGeometry(dsf: DataSetFile, creator: GeometryCreator) -> Geometry
    
}
