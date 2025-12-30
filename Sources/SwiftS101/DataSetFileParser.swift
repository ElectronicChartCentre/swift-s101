//
//  File.swift
//  SwiftS101
//

import Foundation
import SwiftISO8211

struct DataSetFileParser {
    
    static func parse(data: Data) -> DataSetFile? {
        
        let reader = DataReader(data: data)
        guard let ddr = DataDescriptiveRecord.create(reader: reader) else {
            return nil
        }
        
        let dsf = DataSetFile()
        
        while reader.hasMore() {
            guard let record = DataRecord.create(reader: reader, ddr: ddr) else {
                return nil
            }
            
            var currentRecord: Record? = nil

            for node in record.fieldNodes {
                switch node.fieldTag {
                case "DSID":
                    let info = DataSetGeneralInformationRecord()
                    info.dsid = DataSetIdentificationField.create(node)
                    dsf.generalInformation = info
                    currentRecord = info
                case "DSSI":
                    if let info = currentRecord as? DataSetGeneralInformationRecord {
                        let dssi = DataSetStructureInformationField.create(node)
                        info.dssi = dssi
                    }
                case "ATCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let atcs = AttributeCodesField.create(node) {
                        info.addAtcs(atcs)
                    }
                case "ITCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let itcs = InformationTypeCodesField.create(node) {
                        info.addItcs(itcs)
                    }
                case "FTCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let ftcs = FeatureTypeCodesField.create(node) {
                        info.addFtcs(ftcs)
                    }
                case "IACS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let iacs = InformationAssociationCodesField.create(node) {
                        info.addIacs(iacs)
                    }
                case "FACS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let facs = FeatureAssociationCodesField.create(node) {
                        info.addFacs(facs)
                    }
                case "ARCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let arcs = AssociationRoleCodesField.create(node) {
                        info.addArcs(arcs)
                    }
                default:
                    print("TODO: unsupported field tag: \(node.fieldTag)")
                }
            }
            
        }
        
        return dsf
    }
    
    
}
