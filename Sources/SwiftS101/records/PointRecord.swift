//
//  File.swift
//  swift-s101
//

import Foundation

public class PointRecord: RecordWithINAS, GeometryRecord {
    
    public let prid: PRID
    private var c2it: C2IT?
    private var c3it: C3IT?
    
    init(prid: PRID) {
        self.prid = prid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return prid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addC2it(_ c2it: C2IT) {
        if self.c2it != nil {
            print("DEBUG: already have a C2IT. \(self)")
        }
        if self.c3it != nil {
            print("DEBUG: already have a C3IT. \(self)")
        }
        self.c2it = c2it
    }

    func addC3it(_ c3it: C3IT) {
        if self.c2it != nil {
            print("DEBUG: already have a C2IT. \(self)")
        }
        if self.c3it != nil {
            print("DEBUG: already have a C3IT. \(self)")
        }
        self.c3it = c3it
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        guard let dssi = dsf.generalInformation?.dssi else {
            return creator.createEmptyGeometry()
        }
        if let c2it = self.c2it {
            let coord = dssi.createCoordinate2D(xcoo: c2it.xcoo, ycoo: c2it.ycoo, ref: c2it, creator: creator)
            return creator.createPoint(coord: coord)
        }
        if let c3it = self.c3it {
            let coord = dssi.createCoordinate3D(xcoo: c3it.xcoo, ycoo: c3it.ycoo, zcoo: c3it.zcoo, ref: c3it, creator: creator)
            return creator.createPoint(coord: coord)
        }
        return creator.createEmptyGeometry()
    }

}
