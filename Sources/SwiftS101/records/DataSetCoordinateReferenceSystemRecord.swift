//
//  File.swift
//  swift-s101
//

import Foundation

public struct DataSetCoordinateReferenceSystemRecord: Record {
    
    public let csid: CSID
    
    public init(csid: CSID) {
        self.csid = csid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return csid.recordIdentifier
    }
    
}

public class DataSetCoordinateReferenceSystemRecordBuilder: RecordBuilder {
    
    public var csid: CSID
    
    init(csid: CSID) {
        self.csid = csid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return csid.recordIdentifier
    }
    
    func addCrsh(_ crsh: CRSH) {
        
    }
    
    func addCsax(_ csax: CSAX) {
        
    }

    func addVdat(_ vdat: VDAT) {
        
    }
    
    public func build() -> any Record {
        return DataSetCoordinateReferenceSystemRecord(csid: csid)
    }

}
