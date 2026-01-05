//
//  File.swift
//  swift-s101
//

import Foundation

public protocol CoordinatesRecord: Record {
    
    func createCoordinates(dsf: DataSetFile, creator: GeometryCreator) -> [Coordinate]
    
}
