//
//  File.swift
//  swift-s101
//

import Foundation

public struct InformationTypeRecord: RecordWithINAS, Attributable {

    public let irid: IRID
    public let attrs: AttributeFieldList
    public let inass: [INAS]
    
    public init(irid: IRID, attrs: AttributeFieldList, inass: [INAS]) {
        self.irid = irid
        self.attrs = attrs
        self.inass = inass
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return irid.recordIdentifier
    }

}

public class InformationTypeRecordBuilder: RecordBuilderWithINAS {
    
    public var irid: IRID
    public let attrs = AttributeFieldListBuilder()
    private var _inass: [INAS] = []
    
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
        _inass.append(inas)
    }
    
    func addAttr(_ attr: ATTR) {
        let _ = attrs.add(attr: attr)
    }
    
    public func applyModify(update: RecordBuilderWithVersion) -> Self? {
        print("TODO: implement \(type(of: self)).applyModify")
        return nil
    }
    
    public func build() -> any Record {
        return InformationTypeRecord(irid: irid, attrs: attrs.build(), inass: _inass)
    }

}
