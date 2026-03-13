//
//  File.swift
//  SwiftS101
//

import Foundation
import SwiftISO8211

public struct DataSetFileParser {
    
    private static func parse(fileName: String, data: Data, validationResult: ValidationResult) -> DataSetFileBuilder? {
        
        let reader = DataReader(data: data)
        guard let ddr = DataDescriptiveRecord.create(reader: reader) else {
            return nil
        }
        
        let dsf = DataSetFileBuilder()
        
        while reader.hasMore() {
            guard let record = DataRecord.create(reader: reader, ddr: ddr) else {
                return nil
            }
            
            var currentRecord: RecordBuilder? = nil

            for node in record.fieldNodes {
                switch node.fieldTag {
                case "DSID":
                    if let dsid = DSID.create(node) {
                        let info = DataSetGeneralInformationRecordBuilder(dsid: dsid)
                        dsf.generalInformation = info
                        currentRecord = info
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "DSSI":
                    if let info = currentRecord as? DataSetGeneralInformationRecordBuilder {
                        let dssi = DSSI.create(node)
                        info.dssi = dssi
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ATCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecordBuilder, let atcs = ATCS.create(node) {
                        info.addAtcs(atcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ITCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecordBuilder, let itcs = ITCS.create(node) {
                        info.addItcs(itcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FTCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecordBuilder, let ftcs = FTCS.create(node) {
                        info.addFtcs(ftcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "IACS":
                    if let info = currentRecord as? DataSetGeneralInformationRecordBuilder, let iacs = IACS.create(node) {
                        info.addIacs(iacs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FACS":
                    if let info = currentRecord as? DataSetGeneralInformationRecordBuilder, let facs = FACS.create(node) {
                        info.addFacs(facs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ARCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecordBuilder, let arcs = ARCS.create(node) {
                        info.addArcs(arcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CSID":
                    if let csid = CSID.create(node) {
                        let crs = DataSetCoordinateReferenceSystemRecordBuilder(csid: csid)
                        dsf.coordinateReferenceSystem = crs
                        currentRecord = crs
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CRSH":
                    if let crs = currentRecord as? DataSetCoordinateReferenceSystemRecordBuilder, let crsh = CRSH.create(node) {
                        crs.addCrsh(crsh)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CSAX":
                    if let crs = currentRecord as? DataSetCoordinateReferenceSystemRecordBuilder, let csax = CSAX.create(node) {
                        crs.addCsax(csax)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "VDAT":
                    if let crs = currentRecord as? DataSetCoordinateReferenceSystemRecordBuilder, let vdat = VDAT.create(node) {
                        crs.addVdat(vdat)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "IRID":
                    if let irid = IRID.create(node) {
                        let ir = InformationTypeRecordBuilder(irid: irid)
                        dsf.addRecord(ir)
                        currentRecord = ir
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ATTR":
                    if let ir = currentRecord as? InformationTypeRecordBuilder, let attr = ATTR.create(node, dsf: dsf, validationResult: validationResult) {
                        ir.addAttr(attr)
                    } else if let fr = currentRecord as? FeatureTypeRecordBuilder, let attr = ATTR.create(node, dsf: dsf, validationResult: validationResult) {
                        fr.addAttr(attr)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "PRID":
                    if let prid = PRID.create(node) {
                        let pr = PointRecordBuilder(prid: prid)
                        dsf.addRecord(pr)
                        currentRecord = pr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C2IT":
                    if let pr = currentRecord as? PointRecordBuilder, let c2it = C2IT.create(node) {
                        pr.addC2it(c2it)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C3IT":
                    if let pr = currentRecord as? PointRecordBuilder, let c3it = C3IT.create(node) {
                        pr.addC3it(c3it)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CRID":
                    if let crid = CRID.create(node) {
                        let cr = CurveRecordBuilder(crid: crid)
                        dsf.addRecord(cr)
                        currentRecord = cr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "PTAS":
                    if let cr = currentRecord as? CurveRecordBuilder, let ptas = PTAS.create(node) {
                        cr.ptas = ptas
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "SEGH":
                    if let cr = currentRecord as? CurveRecordBuilder, let segh = SEGH.create(node) {
                        cr.addSegh(segh)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C2IL":
                    if let cr = currentRecord as? CurveRecordBuilder, let c2il = C2IL.create(node) {
                        cr.addC2il(c2il)
                    } else if let mpr = currentRecord as? MultiPointRecordBuilder, let c2il = C2IL.create(node) {
                        mpr.addC2il(c2il)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C3IL":
                    if let mpr = currentRecord as? MultiPointRecordBuilder, let c3il = C3IL.create(node) {
                        mpr.addC3il(c3il)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "SRID":
                    if let srid = SRID.create(node) {
                        let sr = SurfaceRecordBuilder(srid: srid)
                        dsf.addRecord(sr)
                        currentRecord = sr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "RIAS":
                    if let sr = currentRecord as? SurfaceRecordBuilder, let rias = RIAS.create(node) {
                        sr.addRias(rias)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FRID":
                    if let frid = FRID.create(node, dsf: dsf, validationResult: validationResult) {
                        let fr = FeatureTypeRecordBuilder(frid: frid)
                        dsf.addRecord(fr)
                        currentRecord = fr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FOID":
                    if let fr = currentRecord as? FeatureTypeRecordBuilder, let foid = FOID.create(node) {
                        fr.foid = foid
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "SPAS":
                    if let fr = currentRecord as? FeatureTypeRecordBuilder, let spas = SPAS.create(node) {
                        fr.addSpas(spas)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "INAS":
                    if let record = currentRecord as? RecordBuilderWithINAS, let inas = INAS.create(node, dsf: dsf, validationResult: validationResult) {
                        record.addInas(inas)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CCID":
                    if let ccid = CCID.create(node) {
                        let ccr = CompositeCurveRecordBuilder(ccid: ccid)
                        dsf.addRecord(ccr)
                        currentRecord = ccr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CUCO":
                    if let ccr = currentRecord as? CompositeCurveRecordBuilder, let cuco = CUCO.create(node) {
                        ccr.addCuco(cuco)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "MRID":
                    if let mrid = MRID.create(node) {
                        let mpr = MultiPointRecordBuilder(mrid: mrid)
                        dsf.addRecord(mpr)
                        currentRecord = mpr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FASC":
                    if let fr = currentRecord as? FeatureTypeRecordBuilder, let fasc = FASC.create(node, dsf: dsf, fileName: fileName, validationResult: validationResult) {
                        fr.addFasc(fasc)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "MASK":
                    if let fr = currentRecord as? FeatureTypeRecordBuilder, let mask = MASK.create(node) {
                        fr.addMask(mask)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                default:
                    print("TODO: unsupported field tag: \(node.fieldTag)")
                }
            }
        }
        
        return dsf
    }
    
    @available(*, deprecated, renamed: "parse(fileName:data:)")
    public static func parse(data: Data) -> (DataSetFileBuilder?, ValidationResult) {
        return parse(fileName: "unknown", data: data)
    }
    
    /**
     * Parse a single S-101 base or reissue file.
     */
    public static func parse(fileName: String, data: Data) -> (DataSetFileBuilder?, ValidationResult) {
        let fileNameDatas: [(String, Data)] = [(fileName, data)]
        return parse(fileNameDatas: fileNameDatas)
    }
    
    /**
     * Parse a single S-101 data set that might have updates. The first data object is the base or reissue file and the laster data objects are updates to that base or reissue.
     */
    public static func parse(fileNameDatas: [(String, Data)]) -> (DataSetFileBuilder?, ValidationResult) {
        let validationResult = ValidationResult()
        
        var combinedDataSetFile: DataSetFileBuilder? = nil
        for (i, (fileName, data)) in fileNameDatas.enumerated() {
            if i == 0 {
                combinedDataSetFile = parse(fileName: fileName, data: data, validationResult: validationResult)
                if combinedDataSetFile == nil {
                    return (combinedDataSetFile, validationResult)
                }
            } else {
                if let combinedDataSetFile, let update = parse(fileName: fileName, data: data, validationResult: validationResult) {
                    DataSetFileUpdater.update(base: combinedDataSetFile, update: update, updateFileName: fileName, validationResult: validationResult)
                } else {
                    return (combinedDataSetFile, validationResult)
                }
            }
        }
        
        return (combinedDataSetFile, validationResult)
    }
    
}
