//
//  File.swift
//  swift-s101
//
//  Created by Tore Halset on 28/12/2025.
//

import Foundation

public class DataSetGeneralInformationRecord: Record {
    
    public var dsid: DataSetIdentificationField?
    public var dssi: DataSetStructureInformationField?
    
    private var atcsByAncd: [Int: AttributeCodesField] = [:]
    private var itcsByItnc: [Int: InformationTypeCodesField] = [:]
    private var ftcsByFtnc: [Int: FeatureTypeCodesField] = [:]
    private var iacsByIanc: [Int: InformationAssociationCodesField] = [:]
    private var facsByFanc: [Int: FeatureAssociationCodesField] = [:]
    private var arcsByArnc: [Int: AssociationRoleCodesField] = [:]

    func addAtcs(_ atcs: AttributeCodesField) {
        atcsByAncd[atcs.ancd] = atcs
    }
    
    func addItcs(_ itcs: InformationTypeCodesField) {
        itcsByItnc[itcs.itnc] = itcs
    }
    
    func addFtcs(_ ftcs: FeatureTypeCodesField) {
        ftcsByFtnc[ftcs.ftnc] = ftcs
    }
    
    func addIacs(_ iacs: InformationAssociationCodesField) {
        iacsByIanc[iacs.ianc] = iacs
    }
    
    func addFacs(_ facs: FeatureAssociationCodesField) {
        facsByFanc[facs.fanc] = facs
    }
    
    func addArcs(_ arcs: AssociationRoleCodesField) {
        arcsByArnc[arcs.arnc] = arcs
    }
    
}
