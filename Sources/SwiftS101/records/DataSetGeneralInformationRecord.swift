//
//  File.swift
//  swift-s101
//

import Foundation

public class DataSetGeneralInformationRecord: Record {
    
    public var dsid: DSID
    public var dssi: DSSI?
    
    private var atcdByAncd: [Int: String] = [:]
    private var itcsByItnc: [Int: ITCS] = [:]
    private var ftcdByFtnc: [Int: String] = [:]
    private var iacsByIanc: [Int: IACS] = [:]
    private var facsByFanc: [Int: FACS] = [:]
    private var arcsByArnc: [Int: ARCS] = [:]

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
        itcsByItnc[itcs.itnc] = itcs
    }
    
    func addFtcs(_ ftcs: FTCS) {
        ftcdByFtnc[ftcs.ftnc] = ftcs.ftcd
    }
    
    func ftcd(ftnc: Int) -> String? {
        return ftcdByFtnc[ftnc]
    }
    
    func addIacs(_ iacs: IACS) {
        iacsByIanc[iacs.ianc] = iacs
    }
    
    func addFacs(_ facs: FACS) {
        facsByFanc[facs.fanc] = facs
    }
    
    func addArcs(_ arcs: ARCS) {
        arcsByArnc[arcs.arnc] = arcs
    }
    
}
