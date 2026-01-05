//
//  File.swift
//  swift-s101
//

import Foundation

public class SurfaceRecord: RecordWithINAS {
    
    public let srid: SRID
    private var riass: [RIAS] = []
    
    init(srid: SRID) {
        self.srid = srid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return srid.recordIdentifier
    }
    
    func addInas(_ inas: INAS) {
        
    }
    
    func addRias(_ rias: RIAS) {
        riass.append(rias)
    }
    
}
