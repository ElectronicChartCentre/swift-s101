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
    
    public func recordVersion() -> RecordVersion {
        return irid.recordVersion
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addAttr(_ attr: ATTR) {
        attrs.add(attr: attr)
    }
    
    public func applyModify(update: RecordWithVersion) -> Self? {
        print("TODO: implement \(type(of: self)).applyModify")
        return nil
    }
    
}
