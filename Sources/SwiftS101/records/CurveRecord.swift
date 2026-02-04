//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public class CurveRecord: RecordWithINAS, GeometryRecord, CoordinatesRecord {
    
    public let crid: CRID
    public var ptas: PTAS?
    private var _segments: [CurveRecordSegment] = []
    private var _inass: [INAS] = []
    
    init(crid: CRID) {
        self.crid = crid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return crid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    public func inass() -> [INAS] {
        return _inass
    }
    
    func addSegh(_ segh: SEGH) {
        let segment = CurveRecordSegment(segh: segh)
        _segments.append(segment)
    }
    
    func addC2il(_ c2il: C2IL) {
        if let lastSegment = _segments.last {
            lastSegment.addC2il(c2il)
        } else {
            print("ERROR: missing segment")
        }
    }
    
    public func segments() -> [CurveRecordSegment] {
        return _segments
    }
    
    public func createCoordinates(dsf: DataSetFile, creator: any GeometryCreator) -> [Coordinate] {
        guard let dssi = dsf.generalInformation?.dssi else {
            return []
        }
        var coords = [Coordinate]()
        for segment in segments() {
            for c2il in segment.c2ils() {
                let coordinate = dssi.createCoordinate2D(xcoo: c2il.xcoo, ycoo: c2il.ycoo, creator: creator)
                coords.append(coordinate)
            }
        }
        return coords
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        let coords = createCoordinates(dsf: dsf, creator: creator)
        return creator.createLineString(coords: coords)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator, forward: Bool) -> any Geometry {
        var coords = createCoordinates(dsf: dsf, creator: creator)
        if !forward {
            coords.reverse()
        }
        return creator.createLineString(coords: coords)
    }
    
    public func spatialType() -> String {
        return "Curve"
    }
    
    public class CurveRecordSegment {
        
        public let segh: SEGH
        private var _c2ils: [C2IL] = []

        init(segh: SEGH) {
            self.segh = segh
        }
        
        func addC2il(_ c2il: C2IL) {
            _c2ils.append(c2il)
        }
        
        public func c2ils() -> [C2IL] {
            return _c2ils
        }
        
    }
    
}
