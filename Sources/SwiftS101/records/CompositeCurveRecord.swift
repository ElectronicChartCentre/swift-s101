//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftGeo

public struct CompositeCurveRecord: GeometryRecord, CoordinatesRecord {
    
    public let ccid: CCID
    public let cucos: [CUCO]
    public let inass: [INAS]
    
    public init(ccid: CCID, cucos: [CUCO], inass: [INAS]) {
        self.ccid = ccid
        self.cucos = cucos
        self.inass = inass
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return ccid.recordIdentifier
    }

    public func createCoordinates(dsf: DataSetFile, creator: any GeometryCreator) -> any CoordinateSequence {
        var css = [any CoordinateSequence]()
        for cuco in cucos {
            guard let record = dsf.record(forIdentifier: cuco.referencedRecordIdentifier) as? CoordinatesRecord else {
                print("DEBUG: CUCO not pointing to coordinates record. \(cuco)")
                continue
            }
            var cucoCoordinates = record.createCoordinates(dsf: dsf, creator: creator)
            if cuco.ornt == CUCO.orntReverse {
                cucoCoordinates = ReverseCoordinateSequence(cucoCoordinates)
            }
            css.append(cucoCoordinates)
        }
        return MultiCoordinateSequence.create(css)
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        var lineStrings = [any Geometry]()
        for cuco in cucos {
            guard let record = dsf.record(forIdentifier: cuco.referencedRecordIdentifier) as? CoordinatesRecord else {
                print("DEBUG: CUCO not pointing to coordinates record. \(cuco)")
                continue
            }
            var cucoCoordinates = record.createCoordinates(dsf: dsf, creator: creator)
            if cuco.ornt == CUCO.orntReverse {
                cucoCoordinates = ReverseCoordinateSequence(cucoCoordinates)
            }
            let cucoLineString = creator.createLineString(coords: cucoCoordinates)
            lineStrings.append(cucoLineString)
        }

        return creator.createGeometry(geometries: lineStrings)
    }
    
    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator, forward: Bool) -> any Geometry {
        // not relevant?
        return createGeometry(dsf: dsf, creator: creator)
    }
    
    public func spatialType() -> String {
        return "CompositeCurve"
    }
    
}

public class CompositeCurveRecordBuilder: RecordBuilderWithVersion {
    
    public let ccid: CCID
    private var _cucos: [CUCO] = []
    private var _inass: [INAS] = []
    
    init(ccid: CCID) {
        self.ccid = ccid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return ccid.recordIdentifier
    }
    
    public func recordVersion() -> RecordVersion {
        return ccid.recordVersion
    }
    
    func addInas(_ inas: INAS) {
        _inass.append(inas)
    }
    
    public func inass() -> [INAS] {
        return _inass
    }
    
    func addCuco(_ cuco: CUCO) {
        _cucos.append(cuco)
    }
    
    public func cucos() -> [CUCO] {
        return _cucos
    }

    public func applyModify(update: RecordBuilderWithVersion) -> Self? {
        print("TODO: implement \(type(of: self)).applyModify")
        return nil
    }
    
    public func build() -> any Record {
        return CompositeCurveRecord(ccid: ccid, cucos: _cucos, inass: _inass)
    }
    
}
