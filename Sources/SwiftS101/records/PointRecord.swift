//
//  File.swift
//  swift-s101
//

import Foundation

public class PointRecord: Record {
    
    public let prid: PRID
    
    init(prid: PRID) {
        self.prid = prid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return prid.recordIdentifier
    }
    
    func addC2it(_ c2it: C2IT) {
        
    }

    func addC3it(_ c3it: C3IT) {
        
    }

}
