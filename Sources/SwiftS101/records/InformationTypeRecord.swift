//
//  File.swift
//  swift-s101
//

import Foundation

public class InformationTypeRecord: RecordWithINAS, Attributable {
    
    public var irid: IRID
    public let attrs = AttributeFieldList()
    
    init(irid: IRID) {
        self.irid = irid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return irid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addAttr(_ attr: ATTR) {
        attrs.add(attr: attr)
    }
    
}
