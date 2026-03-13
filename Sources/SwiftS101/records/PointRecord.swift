//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public struct PointRecord: GeometryRecord {
    
    public let prid: PRID
    public let c2it: C2IT?
    public let c3it: C3IT?
    public let inass: [INAS]
    
    public init(prid: PRID, c2it: C2IT?, c3it: C3IT?, inass: [INAS]) {
        self.prid = prid
        self.c2it = c2it
        self.c3it = c3it
        self.inass = inass
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return prid.recordIdentifier
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        guard let dssi = dsf.generalInformation?.dssi else {
            return creator.createEmptyGeometry()
        }
        if let c2it = self.c2it {
            let coord = dssi.createCoordinate2D(xcoo: c2it.xcoo, ycoo: c2it.ycoo, creator: creator)
            return creator.createPoint(coord: coord)
        }
        if let c3it = self.c3it {
            let coord = dssi.createCoordinate3D(xcoo: c3it.xcoo, ycoo: c3it.ycoo, zcoo: c3it.zcoo, creator: creator)
            return creator.createPoint(coord: coord)
        }
        return creator.createEmptyGeometry()
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator, forward: Bool) -> any Geometry {
        return createGeometry(dsf: dsf, creator: creator)
    }
    
    public func spatialType() -> String {
        return "Point"
    }
    
}

public class PointRecordBuilder: RecordBuilderWithINAS {
    
    public let prid: PRID
    private var _c2it: C2IT?
    private var _c3it: C3IT?
    private var _inass: [INAS] = []
    
    init(prid: PRID) {
        self.prid = prid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return prid.recordIdentifier
    }
    
    public func recordVersion() -> RecordVersion {
        return prid.recordVersion
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    public func inass() -> [INAS] {
        return _inass
    }
    
    func addC2it(_ c2it: C2IT) {
        if self._c2it != nil {
            print("DEBUG: already have a C2IT. \(self)")
        }
        if self._c3it != nil {
            print("DEBUG: already have a C3IT. \(self)")
        }
        self._c2it = c2it
    }
    
    public func c2it() -> C2IT? {
        return _c2it
    }

    func addC3it(_ c3it: C3IT) {
        if self._c2it != nil {
            print("DEBUG: already have a C2IT. \(self)")
        }
        if self._c3it != nil {
            print("DEBUG: already have a C3IT. \(self)")
        }
        self._c3it = c3it
    }
    
    public func c3it() -> C3IT? {
        return _c3it
    }
    
    public func applyModify(update: RecordBuilderWithVersion) -> Self? {
        print("TODO: implement \(type(of: self)).applyModify")
        return nil
    }
    
    public func build() -> any Record {
        return PointRecord(prid: prid, c2it: _c2it, c3it: _c3it, inass: _inass)
    }

}
