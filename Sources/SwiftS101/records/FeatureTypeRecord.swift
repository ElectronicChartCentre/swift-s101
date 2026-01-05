//
//  File.swift
//  swift-s101
//

import Foundation

public class FeatureTypeRecord: RecordWithINAS {
    
    public let frid: FRID
    public var foid: FOID?
    
    init(frid: FRID) {
        self.frid = frid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return frid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    public func addAttr(_ attr: ATTR) {
        
    }
    
    public func addSpas(_ spas: SPAS) {
        
    }
    
}
