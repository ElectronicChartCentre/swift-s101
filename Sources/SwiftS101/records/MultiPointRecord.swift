//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public class MultiPointRecord: RecordWithINAS, GeometryRecord, CoordinatesRecord {
    
    public let mrid: MRID
    private var _c2ils: [C2IL] = []
    private var _c3ils: [C3IL] = []
    private var _inass: [INAS] = []

    init(mrid: MRID) {
        self.mrid = mrid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return mrid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    public func inass() -> [INAS] {
        return _inass
    }
    
    func addC2il(_ c2il: C2IL) {
        _c2ils.append(c2il)
    }
    
    public func c2ils() -> [C2IL] {
        return _c2ils
    }
    
    func addC3il(_ c3il: C3IL) {
        _c3ils.append(c3il)
    }
    
    public func c3ils() -> [C3IL] {
        return _c3ils
    }
    
    public func createCoordinates(dsf: DataSetFile, creator: any GeometryCreator) -> [any Coordinate] {
        
        guard let dssi = dsf.generalInformation?.dssi else {
            return []
        }
        
        var coords: [any Coordinate] = []
        for c2il in _c2ils {
            coords.append(dssi.createCoordinate2D(xcoo: c2il.xcoo, ycoo: c2il.ycoo, creator: creator))
        }
        for c3il in _c3ils {
            for c3it in c3il.c3its {
                coords.append(dssi.createCoordinate3D(xcoo: c3it.xcoo, ycoo: c3it.ycoo, zcoo: c3it.zcoo, creator: creator))
            }
        }
        return coords
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        let coords = createCoordinates(dsf: dsf, creator: creator)
        return creator.createMultiPoint(coords: coords)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator, forward: Bool) -> any Geometry {
        return createGeometry(dsf: dsf, creator: creator)
    }
    
    public func spatialType() -> String {
        return "MultiPoint"
    }
    
}
