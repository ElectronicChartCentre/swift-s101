//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public protocol CoordinatesRecord: Record {
    
    func createCoordinates(dsf: DataSetFile, creator: GeometryCreator) -> [Coordinate]
    
}
