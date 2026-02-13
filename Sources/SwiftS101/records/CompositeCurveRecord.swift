//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public class CompositeCurveRecord: GeometryRecord, CoordinatesRecord {
    
    public let ccid: CCID
    private var _cucos: [CUCO] = []
    private var _inass: [INAS] = []
    
    init(ccid: CCID) {
        self.ccid = ccid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return ccid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    public func inass() -> [INAS] {
        return _inass
    }
    
    func addCuco(_ cuco: CUCO) {
        _cucos.append(cuco)
    }
    
    public func cucos() -> [CUCO] {
        return _cucos
    }
    
    public func createCoordinates(dsf: DataSetFile, creator: any GeometryCreator) -> [any Coordinate] {
        var coords = [any Coordinate]()
        for cuco in _cucos {
            guard let record = dsf.record(forIdentifier: cuco.referencedRecordIdentifier) as? CoordinatesRecord else {
                print("DEBUG: CUCO not pointing to coordinates record. \(cuco)")
                continue
            }
            var cucoCoordinates = record.createCoordinates(dsf: dsf, creator: creator)
            if cuco.ornt == CUCO.orntReverse {
                cucoCoordinates.reverse()
            }
            coords.append(contentsOf: cucoCoordinates)
        }
        return coords
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        let coords = createCoordinates(dsf: dsf, creator: creator)
        return creator.createLineString(coords: coords)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator, forward: Bool) -> any Geometry {
        // not relevant?
        return createGeometry(dsf: dsf, creator: creator)
    }
    
    public func spatialType() -> String {
        return "CompositeCurve"
    }
    
}
