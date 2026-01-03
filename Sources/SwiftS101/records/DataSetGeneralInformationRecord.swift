//
//  File.swift
//  swift-s101
//

import Foundation

public class DataSetGeneralInformationRecord: Record {
    
    public var dsid: DSID
    public var dssi: DSSI?
    
    private var atcsByAncd: [Int: ATCS] = [:]
    private var itcsByItnc: [Int: ITCS] = [:]
    private var ftcsByFtnc: [Int: FTCS] = [:]
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
        atcsByAncd[atcs.ancd] = atcs
    }
    
    func addItcs(_ itcs: ITCS) {
        itcsByItnc[itcs.itnc] = itcs
    }
    
    func addFtcs(_ ftcs: FTCS) {
        ftcsByFtnc[ftcs.ftnc] = ftcs
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
