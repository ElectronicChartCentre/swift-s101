//
//  File.swift
//  swift-s101
//

import Foundation

public class InformationTypeRecord: Record {
    
    public var irid: IRID
    
    init(irid: IRID) {
        self.irid = irid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return irid.recordIdentifier
    }
    
    func addAttr(_ attr: ATTR) {
        
    }
    
}
