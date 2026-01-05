//
//  File.swift
//  swift-s101
//

import Foundation

public class CurveRecord: RecordWithINAS, GeometryRecord {
    
    public let crid: CRID
    public var ptas: PTAS?
    public var segh: SEGH?
    private var c2ils: [C2IL] = []
    
    init(crid: CRID) {
        self.crid = crid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return crid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    public func addC2il(_ c2il: C2IL) {
        c2ils.append(c2il)
    }
    
    public func createCoordinates(dsf: DataSetFile, creator: any GeometryCreator) -> [Coordinate] {
        guard let dssi = dsf.generalInformation?.dssi else {
            return []
        }
        var coords = [Coordinate]()
        for c2il in c2ils {
            let coordinate = dssi.createCoordinate2D(xcoo: c2il.xcoo, ycoo: c2il.ycoo, ref: c2il, creator: creator)
            coords.append(coordinate)
        }
        return coords
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        let coords = createCoordinates(dsf: dsf, creator: creator)
        return creator.createLineString(coords: coords)
    }
    
}
