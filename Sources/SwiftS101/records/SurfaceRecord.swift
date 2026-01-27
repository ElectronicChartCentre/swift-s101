//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public class SurfaceRecord: RecordWithINAS, GeometryRecord {
    
    public let srid: SRID
    private var _riass: [RIAS] = []
    
    init(srid: SRID) {
        self.srid = srid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return srid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addRias(_ rias: RIAS) {
        _riass.append(rias)
    }
    
    public func riass() -> [RIAS] {
        return _riass
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {

        var shell: LinearRing?
        var holes: [LinearRing] = []
        
        for rias in _riass {
            guard let record = dsf.record(forIdentifier: rias.referencedRecordIdentifier) as? CoordinatesRecord else {
                print("DEBUG: could not find coordinates record for identifier: \(rias.referencedRecordIdentifier)")
                continue
            }
            
            var coords = record.createCoordinates(dsf: dsf, creator: creator)
            if rias.ornt == RIAS.orntReverse {
                coords.reverse()
            }
            
            let ring = creator.createLinearRing(coords: coords)
            switch(rias.usag) {
            case RIAS.usagExterior:
                shell = ring
            case RIAS.usagInterior:
                holes.append(ring)
            default:
                print("DEBUG: unsupported usage value \(rias.usag)")
            }
        }
        
        guard let shell = shell else {
            print("DEBUG: missing shell?")
            return creator.createEmptyGeometry()
        }
        
        return creator.createPolygon(shell: shell, holes: holes)
    }
    
    public func spatialType() -> String {
        return "Surface"
    }
    
}
