//
//  File.swift
//  swift-s101
//

import Foundation

public class DataSetCoordinateReferenceSystemRecord: Record {
    
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

}
