//
//  File.swift
//  swift-s101
//

import Foundation

public class DataSetGeneralInformationRecord: Record {
    
    public var dsid: DSID
    public var dssi: DSSI?
    
    private var atcdByAncd: [Int: String] = [:]
    private var itcdByItnc: [Int: String] = [:]
    private var ftcdByFtnc: [Int: String] = [:]
    private var iacdByIanc: [Int: String] = [:]
    private var facdByFanc: [Int: String] = [:]
    private var arcdByArnc: [Int: String] = [:]

    init(dsid: DSID) {
        self.dsid = dsid
    }
    
    public func recordIdentifier() -> RecordIdentifier {
        return dsid.recordIdentifier
    }
    
    func addAtcs(_ atcs: ATCS) {
        atcdByAncd[atcs.ancd] = atcs.atcd
    }
    
    func atcd(_ ancd: Int) -> String? {
        return atcdByAncd[ancd]
    }
    
    func addItcs(_ itcs: ITCS) {
        itcdByItnc[itcs.itnc] = itcs.itcd
    }
    
    public func itcd(itnc: Int) -> String? {
        return itcdByItnc[itnc]
    }
    
    func addFtcs(_ ftcs: FTCS) {
        ftcdByFtnc[ftcs.ftnc] = ftcs.ftcd
    }
    
    func ftcd(ftnc: Int) -> String? {
        return ftcdByFtnc[ftnc]
    }
    
    func addIacs(_ iacs: IACS) {
        iacdByIanc[iacs.ianc] = iacs.iacd
    }
    
    func iacd(ianc: Int) -> String? {
        return iacdByIanc[ianc]
    }
    
    func addFacs(_ facs: FACS) {
        facdByFanc[facs.fanc] = facs.facd
    }
    
    func facd(fanc: Int) -> String? {
        return facdByFanc[fanc]
    }
    
    func addArcs(_ arcs: ARCS) {
        arcdByArnc[arcs.arnc] = arcs.arcd
    }
    
    func arcd(arnc: Int) -> String? {
        return arcdByArnc[arnc]
    }
    
}
