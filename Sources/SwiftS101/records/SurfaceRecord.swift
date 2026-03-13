//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public struct SurfaceRecord: RecordWithINAS, GeometryRecord {
    
    public let srid: SRID
    public let riass: [RIAS]
    public let inass: [INAS]
    
    public init(srid: SRID, riass: [RIAS], inass: [INAS]) {
        self.srid = srid
        self.riass = riass
        self.inass = inass
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return srid.recordIdentifier
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {

        var shell: LinearRing?
        var holes: [LinearRing] = []
        
        for rias in riass {
            guard let record = dsf.record(forIdentifier: rias.referencedRecordIdentifier) as? CoordinatesRecord else {
                print("DEBUG: could not find coordinates record for identifier: \(rias.referencedRecordIdentifier)")
                continue
            }
            
            var coords = record.createCoordinates(dsf: dsf, creator: creator)
            if rias.ornt == RIAS.orntReverse {
                coords = ReverseCoordinateSequence(coords)
            }
            
            let ring = creator.createLinearRing(coords: coords)
            switch rias.usag {
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
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator, forward: Bool) -> any Geometry {
        return createGeometry(dsf: dsf, creator: creator)
    }
    
    public func spatialType() -> String {
        return "Surface"
    }

}

public class SurfaceRecordBuilder: RecordBuilderWithINAS {
    
    public let srid: SRID
    private var _riass: [RIAS] = []
    private var _inass: [INAS] = []
    
    init(srid: SRID) {
        self.srid = srid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return srid.recordIdentifier
    }
    
    public func recordVersion() -> RecordVersion {
        return srid.recordVersion
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    public func inass() -> [INAS] {
        return _inass
    }

    func addRias(_ rias: RIAS) {
        _riass.append(rias)
    }
    
    public func riass() -> [RIAS] {
        return _riass
    }

    public func applyModify(update: RecordBuilderWithVersion) -> Self? {
        print("TODO: implement \(type(of: self)).applyModify")
        return nil
    }
    
    public func build() -> any Record {
        return SurfaceRecord(srid: srid, riass: _riass, inass: _inass)
    }
    
}
