//
//  File.swift
//  swift-s101
//

import Foundation

public class CompositeCurveRecord: GeometryRecord, CoordinatesRecord {
    
    public let ccid: CCID
    private var cucos: [CUCO] = []
    
    init(ccid: CCID) {
        self.ccid = ccid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return ccid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    public func addCuco(_ cuco: CUCO) {
        cucos.append(cuco)
    }
    
    public func createCoordinates(dsf: DataSetFile, creator: any GeometryCreator) -> [Coordinate] {
        var coords = [Coordinate]()
        for cuco in cucos {
            guard let record = dsf.record(forIdentifier: cuco.referencedRecordIdentifier) as? CoordinatesRecord else {
                print("DEBUG: CUCO not pointing to coordinates record. \(cuco)")
                continue
            }
            var cucoCoordinates = record.createCoordinates(dsf: dsf, creator: creator)
            if cuco.ornt == CUCO.orntReverse {
                cucoCoordinates.reverse()
            }
            coords.append(contentsOf: cucoCoordinates)
        }
        return coords
    }

    public func createGeometry(dsf: DataSetFile, creator: any GeometryCreator) -> any Geometry {
        let coords = createCoordinates(dsf: dsf, creator: creator)
        return creator.createLineString(coords: coords)
    }
    
}
