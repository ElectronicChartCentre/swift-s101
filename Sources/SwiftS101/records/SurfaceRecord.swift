//
//  File.swift
//  swift-s101
//

import Foundation

public class SurfaceRecord: RecordWithINAS, GeometryRecord {
    
    public let srid: SRID
    private var riass: [RIAS] = []
    
    init(srid: SRID) {
        self.srid = srid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return srid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addRias(_ rias: RIAS) {
        riass.append(rias)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {

        var shell: LinearRing?
        var holes: [LinearRing] = []
        
        for rias in riass {
            guard let record = dsf.record(forIdentifier: rias.referencedRecordIdentifier) else {
                print("DEBUG: could not find geometry record for identifier: \(rias.referencedRecordIdentifier)")
                continue
            }
            
            if let record = record as? CurveRecord {
                let coords = record.createCoordinates(dsf: dsf, creator: creator)
                let ring = creator.createLinearRing(coords: coords)
                switch(rias.usag) {
                case RIAS.usagExterior:
                    shell = ring
                case RIAS.usagInterior:
                    holes.append(ring)
                default:
                    print("DEBUG: unsupported usage value \(rias.usag)")
                }
            } else {
                print("TODO: handle RIAS to non-CurveRecord \(record)")
            }
            
        }
        
        guard let shell = shell else {
            print("DEBUG: missing shell?")
            return creator.createEmptyGeometry()
        }
        
        return creator.createPolygon(shell: shell, holes: holes)
    }
    
}
