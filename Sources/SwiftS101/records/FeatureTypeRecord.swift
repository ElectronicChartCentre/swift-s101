//
//  File.swift
//  swift-s101
//

import Foundation

public class FeatureTypeRecord: RecordWithINAS, Attributable {
    
    public let frid: FRID
    public var foid: FOID?
    private var _spass: [SPAS] = []
    private var _fascs: [FASC] = []
    private var masks: [MASK] = []
    public let attrs = AttributeFieldList()
    
    init(frid: FRID) {
        self.frid = frid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return frid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addAttr(_ attr: ATTR) {
        attrs.add(attr: attr)
    }
    
    func addSpas(_ spas: SPAS) {
        _spass.append(spas)
    }
    
    public func spass() -> [SPAS] {
        return _spass
    }
    
    func addFasc(_ fasc: FASC) {
        _fascs.append(fasc)
    }
    
    public func fascs() -> [FASC] {
        return _fascs
    }
    
    func addMask(_ mask: MASK) {
        masks.append(mask)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: GeometryCreator) -> Geometry {
        var geometries : [Geometry] = []
        
        // should FASC be included to create geometry?
        for fasc in _fascs {
            guard let record = dsf.record(forIdentifier: fasc.referencedRecordIdentifier) else {
                print("DEBUG: could not find record for identifier: \(fasc.referencedRecordIdentifier)")
                continue
            }
            
            if let geometryRecord = record as? GeometryRecord {
                let geometry = geometryRecord.createGeometry(dsf: dsf, creator: creator)
                geometries.append(geometry)
            } else if let featureRecord = record as? FeatureTypeRecord {
                let geometry = featureRecord.createGeometry(dsf: dsf, creator: creator)
                geometries.append(geometry)
            } else {
                print("DEBUG: do not know how to create geometry from \(record)")
            }
            
        }
        
        for spas in _spass {
            guard let record = dsf.record(forIdentifier: spas.referencedRecordIdentifier) else {
                print("DEBUG: could not find record for identifier: \(spas.referencedRecordIdentifier)")
                continue
            }
            
            if spas.ornt == SPAS.orntReverse {
                print("TODO: SPAS ORNT reverse")
            }
            
            if let geometryRecord = record as? GeometryRecord {
                let geometry = geometryRecord.createGeometry(dsf: dsf, creator: creator)
                geometries.append(geometry)
            } else if let featureRecord = record as? FeatureTypeRecord {
                let geometry = featureRecord.createGeometry(dsf: dsf, creator: creator)
                geometries.append(geometry)
            } else {
                print("DEBUG: do not know how to create geometry from \(record)")
            }
        }
        
        return creator.createGeometry(geometries: geometries)
    }
    
}
