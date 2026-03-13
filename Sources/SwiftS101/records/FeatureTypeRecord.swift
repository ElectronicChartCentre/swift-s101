//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo
import OrderedCollections

public struct FeatureTypeRecord: RecordWithINAS, Attributable {
    
    public let frid: FRID
    public var foid: FOID?
    public let inass: [INAS]
    private let _spass: OrderedDictionary<RecordIdentifier, SPAS>
    private let _fascs: OrderedDictionary<RecordIdentifier, FASC>
    private let _masks: OrderedDictionary<RecordIdentifier, MASK>
    public let attrs: AttributeFieldList
    
    init(frid: FRID, foid: FOID?, inass: [INAS], spass: OrderedDictionary<RecordIdentifier, SPAS>, fascs: OrderedDictionary<RecordIdentifier, FASC>, masks: OrderedDictionary<RecordIdentifier, MASK>, attrs: AttributeFieldList) {
        self.frid = frid
        self.foid = foid
        self.inass = inass
        self._spass = spass
        self._fascs = fascs
        self._masks = masks
        self.attrs = attrs
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return frid.recordIdentifier
    }
    
    public func spass() -> [SPAS] {
        return _spass.values.elements
    }
    
    public func fascs() -> [FASC] {
        return _fascs.values.elements
    }
    
    public func masks() -> [MASK] {
        return _masks.values.elements
    }
    
    public func createGeometry(dsf: DataSetFile, creator: GeometryCreator) -> Geometry {
        var recordIdentifiers: Set<RecordIdentifier> = []
        return createGeometry(dsf: dsf, creator: creator, recordIdentifiers: &recordIdentifiers)
    }
    
    private func createGeometry(dsf: DataSetFile, creator: GeometryCreator, recordIdentifiers: inout Set<RecordIdentifier>) -> Geometry {
        
        var geometries : [Geometry] = []
        
        // should FASC be included to create geometry?
        for fasc in _fascs.values {

            // prevent circular references and double geometries
            if !recordIdentifiers.insert(fasc.referencedRecordIdentifier).inserted {
                continue
            }

            guard let record = dsf.record(forIdentifier: fasc.referencedRecordIdentifier) else {
                print("DEBUG: FeatureTypeRecord.createGeometry FASC could not find record for identifier: \(fasc.referencedRecordIdentifier)")
                continue
            }
            
            if let geometryRecord = record as? GeometryRecord {
                let geometry = geometryRecord.createGeometry(dsf: dsf, creator: creator)
                geometries.append(geometry)
            } else if let featureRecord = record as? FeatureTypeRecord {
                let geometry = featureRecord.createGeometry(dsf: dsf, creator: creator, recordIdentifiers: &recordIdentifiers)
                geometries.append(geometry)
            } else {
                print("DEBUG: do not know how to create geometry from \(record)")
            }
            
        }
        
        for spas in _spass.values {
            
            // prevent circular references and double geometries
            if !recordIdentifiers.insert(spas.referencedRecordIdentifier).inserted {
                continue
            }
            
            guard let record = dsf.record(forIdentifier: spas.referencedRecordIdentifier) else {
                print("DEBUG: FeatureTypeRecord.createGeometry SPAS could not find record for identifier: \(spas.referencedRecordIdentifier)")
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
        
        return creator.createGeometry(geometries: geometries)
    }
    
}

public class FeatureTypeRecordBuilder: RecordBuilderWithINAS {
    
    public let frid: FRID
    public var foid: FOID?
    private var _inass: [INAS] = []
    private var _spass: OrderedDictionary<RecordIdentifier, SPAS> = [:]
    private var _fascs: OrderedDictionary<RecordIdentifier, FASC> = [:]
    private var _masks: OrderedDictionary<RecordIdentifier, MASK> = [:]
    public let attrs = AttributeFieldListBuilder()
    
    required init(frid: FRID) {
        self.frid = frid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return frid.recordIdentifier
    }
    
    public func recordVersion() -> RecordVersion {
        return frid.recordVersion
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    func addAttr(_ attr: ATTR) {
        let _ = attrs.add(attr: attr)
    }
    
    func addSpas(_ spas: SPAS) {
        _spass[spas.referencedRecordIdentifier] = spas
    }
    
    func removeSpas(_ spas: SPAS) {
        _spass.removeValue(forKey: spas.referencedRecordIdentifier)
    }
    
    public func spass() -> [SPAS] {
        return _spass.values.elements
    }
    
    func addFasc(_ fasc: FASC) {
        _fascs[fasc.referencedRecordIdentifier] = fasc
    }
    
    func removeFasc(_ fasc: FASC) {
        _fascs.removeValue(forKey: fasc.referencedRecordIdentifier)
    }
    
    public func fascs() -> [FASC] {
        return _fascs.values.elements
    }
    
    func addMask(_ mask: MASK) {
        _masks[mask.referencedRecordIdentifier] = mask
    }
    
    func removeMask(_ mask: MASK) {
        _masks.removeValue(forKey: mask.referencedRecordIdentifier)
    }
    
    public func masks() -> [MASK] {
        return _masks.values.elements
    }
    
    
    public func applyModify(update: RecordBuilderWithVersion) -> Self? {
        
        guard let update = update as? FeatureTypeRecordBuilder else {
            return nil
        }
        
        let result = type(of: self).init(frid: update.frid)
        result.foid = self.foid
        
        result.attrs.addAll(attrs: self.attrs.attrs())
        result.attrs.applyModify(updateAttrs: update.attrs)
        
        result._spass = self._spass
        result._fascs = self._fascs
        result._masks = self._masks
                
        for spas in update.spass() {
            switch spas.saui {
            case 1:
                result.addSpas(spas)
            case 2:
                result.removeSpas(spas)
            default:
                print("ERROR: unsupported SPAS.SAUI=\(spas.saui)")
            }
        }
        
        for fasc in update.fascs() {
            switch fasc.faui {
            case 1:
                result.addFasc(fasc)
            case 2:
                result.removeFasc(fasc)
            default:
                print("ERROR: unsupported FASC.FAUI=\(fasc.faui)")
            }
        }
        
        for mask in update.masks() {
            switch mask.muin {
            case 1:
                result.addMask(mask)
            case 2:
                result.removeMask(mask)
            default:
                print("ERROR: unsupported MASK.MUIN=\(mask.muin)")
            }
        }
        
        return result
    }
    
    public func build() -> any Record {
        return FeatureTypeRecord(frid: frid, foid: foid, inass: _inass, spass: _spass, fascs: _fascs, masks: _masks, attrs: attrs.build())
    }
    
}
