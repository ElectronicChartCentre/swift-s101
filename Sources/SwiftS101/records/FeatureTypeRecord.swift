//
//  File.swift
//  swift-s101
//

import Foundation

public class FeatureTypeRecord: RecordWithINAS {
    
    public let frid: FRID
    public var foid: FOID?
    private var spass: [SPAS] = []
    
    init(frid: FRID) {
        self.frid = frid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return frid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    public func addAttr(_ attr: ATTR) {
        
    }
    
    public func addSpas(_ spas: SPAS) {
        spass.append(spas)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: GeometryCreator) -> Geometry {
        var geometries : [Geometry] = []
        for spas in spass {
            // TODO: use SPAS.ORNT?
            guard let geometryRecord = dsf.record(forIdentifier: spas.referencedRecordIdentifier) as? GeometryRecord else {
                print("DEBUG: could not find geometry record for identifier: \(spas.referencedRecordIdentifier)")
                continue
            }
            let geometry = geometryRecord.createGeometry(dsf: dsf, creator: creator)
            geometries.append(geometry)
        }
        
        return creator.createGeometry(geometries: geometries)
    }
    
}
