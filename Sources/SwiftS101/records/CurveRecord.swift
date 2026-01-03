//
//  File.swift
//  swift-s101
//

import Foundation

public class CurveRecord: Record {
    
    public let crid: CRID
    
    init(crid: CRID) {
        self.crid = crid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return crid.recordIdentifier
    }
    
}
