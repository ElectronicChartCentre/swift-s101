//
//  File.swift
//  swift-s101
//

import Foundation

public class CurveRecord: RecordWithINAS {
    
    public let crid: CRID
    public var ptas: PTAS?
    public var segh: SEGH?
    private var c2ils: [C2IL] = []
    
    init(crid: CRID) {
        self.crid = crid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return crid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    public func addC2il(_ c2il: C2IL) {
        c2ils.append(c2il)
    }
    
}
