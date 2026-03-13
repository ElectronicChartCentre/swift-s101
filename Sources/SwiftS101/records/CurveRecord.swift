//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public struct CurveRecord: RecordWithINAS, GeometryRecord, CoordinatesRecord {
    
    public let crid: CRID
    public let ptas: PTAS?
    public let segments: [CurveRecordSegment]
    public let inass: [INAS]
    
    public init(crid: CRID, ptas: PTAS? = nil, segments: [CurveRecordSegment], inass: [INAS]) {
        self.crid = crid
        self.ptas = ptas
        self.segments = segments
        self.inass = inass
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return crid.recordIdentifier
    }
    
    public func createCoordinates(dsf: DataSetFile, creator: any GeometryCreator) -> any CoordinateSequence {
        guard let dssi = dsf.generalInformation?.dssi else {
            return MultiCoordinateSequence([])
        }
        var coords = [any Coordinate]()
        for segment in segments {
            for c2il in segment.c2ils {
                let coordinate = dssi.createCoordinate2D(xcoo: c2il.xcoo, ycoo: c2il.ycoo, creator: creator)
                coords.append(coordinate)
            }
        }
        return ArrayCoordinateSequence(coords, ref: recordIdentifier())
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        let coords = createCoordinates(dsf: dsf, creator: creator)
        return creator.createLineString(coords: coords)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator, forward: Bool) -> any Geometry {
        var coords = createCoordinates(dsf: dsf, creator: creator)
        if !forward {
            coords = ReverseCoordinateSequence(coords)
        }
        return creator.createLineString(coords: coords)
    }
    
    public func spatialType() -> String {
        return "Curve"
    }

    
    public struct CurveRecordSegment: Sendable {
        
        public let segh: SEGH
        public let c2ils: [C2IL]

        init(segh: SEGH, c2ils: [C2IL]) {
            self.segh = segh
            self.c2ils = c2ils
        }
        
    }
    
}

public class CurveRecordBuilder: RecordBuilderWithINAS {
    
    public let crid: CRID
    public var ptas: PTAS?
    private var _segments: [CurveRecordSegmentBuilder] = []
    private var _inass: [INAS] = []
    
    init(crid: CRID) {
        self.crid = crid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return crid.recordIdentifier
    }
    
    public func recordVersion() -> RecordVersion {
        return crid.recordVersion
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    public func inass() -> [INAS] {
        return _inass
    }
    
    func addSegh(_ segh: SEGH) {
        let segment = CurveRecordSegmentBuilder(segh: segh)
        _segments.append(segment)
    }
    
    func addC2il(_ c2il: C2IL) {
        if let lastSegment = _segments.last {
            lastSegment.addC2il(c2il)
        } else {
            print("ERROR: missing segment")
        }
    }
    
    public func segments() -> [CurveRecordSegmentBuilder] {
        return _segments
    }
        
    public class CurveRecordSegmentBuilder {
        
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
        
        public func build() -> CurveRecord.CurveRecordSegment {
            return .init(segh: segh, c2ils: _c2ils)
        }
        
    }
    
    public func applyModify(update: RecordBuilderWithVersion) -> Self? {
        print("TODO: implement \(type(of: self)).applyModify")
        return nil
    }
    
    public func build() -> any Record {
        var ss: [CurveRecord.CurveRecordSegment] = []
        for segment in _segments {
            ss.append(segment.build())
        }
        return CurveRecord(crid: crid, ptas: ptas, segments: ss, inass: _inass)
    }
    
}
