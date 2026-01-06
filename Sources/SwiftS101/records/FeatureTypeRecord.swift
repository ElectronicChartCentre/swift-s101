//
//  File.swift
//  swift-s101
//

import Foundation

public class FeatureTypeRecord: RecordWithINAS {
    
    public let frid: FRID
    public var foid: FOID?
    private var spass: [SPAS] = []
    private var fascs: [FASC] = []
    private var masks: [MASK] = []
    
    init(frid: FRID) {
        self.frid = frid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return frid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addAttr(_ attr: ATTR) {
        
    }
    
    func addSpas(_ spas: SPAS) {
        spass.append(spas)
    }
    
    func addFasc(_ fasc: FASC) {
        fascs.append(fasc)
    }
    
    func addMask(_ mask: MASK) {
        masks.append(mask)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: GeometryCreator) -> Geometry {
        var geometries : [Geometry] = []
        for spas in spass {
            guard let geometryRecord = dsf.record(forIdentifier: spas.referencedRecordIdentifier) as? GeometryRecord else {
                print("DEBUG: could not find geometry record for identifier: \(spas.referencedRecordIdentifier)")
                continue
            }
            
            if spas.ornt == SPAS.orntReverse {
                print("TODO: SPAS ORNT reverse")
            }
            
            let geometry = geometryRecord.createGeometry(dsf: dsf, creator: creator)
            geometries.append(geometry)
        }
        
        return creator.createGeometry(geometries: geometries)
    }
    
}
