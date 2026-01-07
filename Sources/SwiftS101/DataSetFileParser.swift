//
//  File.swift
//  SwiftS101
//

import Foundation
import SwiftISO8211

struct DataSetFileParser {
    
    static func parse(data: Data) -> (DataSetFile?, ValidationResult) {
        
        let validationResult = ValidationResult()
        
        let reader = DataReader(data: data)
        guard let ddr = DataDescriptiveRecord.create(reader: reader) else {
            return (nil, validationResult)
        }
        
        let dsf = DataSetFile()
        
        while reader.hasMore() {
            guard let record = DataRecord.create(reader: reader, ddr: ddr) else {
                return (nil, validationResult)
            }
            
            var currentRecord: Record? = nil

            for node in record.fieldNodes {
                switch node.fieldTag {
                case "DSID":
                    if let dsid = DSID.create(node) {
                        let info = DataSetGeneralInformationRecord(dsid: dsid)
                        dsf.generalInformation = info
                        currentRecord = info
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "DSSI":
                    if let info = currentRecord as? DataSetGeneralInformationRecord {
                        let dssi = DSSI.create(node)
                        info.dssi = dssi
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ATCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let atcs = ATCS.create(node) {
                        info.addAtcs(atcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ITCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let itcs = ITCS.create(node) {
                        info.addItcs(itcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FTCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let ftcs = FTCS.create(node) {
                        info.addFtcs(ftcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "IACS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let iacs = IACS.create(node) {
                        info.addIacs(iacs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FACS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let facs = FACS.create(node) {
                        info.addFacs(facs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ARCS":
                    if let info = currentRecord as? DataSetGeneralInformationRecord, let arcs = ARCS.create(node) {
                        info.addArcs(arcs)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CSID":
                    if let csid = CSID.create(node) {
                        let crs = DataSetCoordinateReferenceSystemRecord(csid: csid)
                        dsf.coordinateReferenceSystem = crs
                        currentRecord = crs
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CRSH":
                    if let crs = currentRecord as? DataSetCoordinateReferenceSystemRecord, let crsh = CRSH.create(node) {
                        crs.addCrsh(crsh)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CSAX":
                    if let crs = currentRecord as? DataSetCoordinateReferenceSystemRecord, let csax = CSAX.create(node) {
                        crs.addCsax(csax)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "VDAT":
                    if let crs = currentRecord as? DataSetCoordinateReferenceSystemRecord, let vdat = VDAT.create(node) {
                        crs.addVdat(vdat)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "IRID":
                    if let irid = IRID.create(node) {
                        let ir = InformationTypeRecord(irid: irid)
                        dsf.addRecord(ir)
                        currentRecord = ir
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "ATTR":
                    if let ir = currentRecord as? InformationTypeRecord, let attr = ATTR.create(node) {
                        ir.addAttr(attr)
                    } else if let fr = currentRecord as? FeatureTypeRecord, let attr = ATTR.create(node) {
                        fr.addAttr(attr)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "PRID":
                    if let prid = PRID.create(node) {
                        let pr = PointRecord(prid: prid)
                        dsf.addRecord(pr)
                        currentRecord = pr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C2IT":
                    if let pr = currentRecord as? PointRecord, let c2it = C2IT.create(node) {
                        pr.addC2it(c2it)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C3IT":
                    if let pr = currentRecord as? PointRecord, let c3it = C3IT.create(node) {
                        pr.addC3it(c3it)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CRID":
                    if let crid = CRID.create(node) {
                        let cr = CurveRecord(crid: crid)
                        dsf.addRecord(cr)
                        currentRecord = cr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "PTAS":
                    if let cr = currentRecord as? CurveRecord, let ptas = PTAS.create(node) {
                        cr.ptas = ptas
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "SEGH":
                    if let cr = currentRecord as? CurveRecord, let segh = SEGH.create(node) {
                        cr.segh = segh
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C2IL":
                    if let cr = currentRecord as? CurveRecord, let c2il = C2IL.create(node) {
                        cr.addC2il(c2il)
                    } else if let mpr = currentRecord as? MultiPointRecord, let c2il = C2IL.create(node) {
                        mpr.addC2il(c2il)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "C3IL":
                    if let mpr = currentRecord as? MultiPointRecord, let c3il = C3IL.create(node) {
                        mpr.addC3il(c3il)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "SRID":
                    if let srid = SRID.create(node) {
                        let sr = SurfaceRecord(srid: srid)
                        dsf.addRecord(sr)
                        currentRecord = sr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "RIAS":
                    if let sr = currentRecord as? SurfaceRecord, let rias = RIAS.create(node) {
                        sr.addRias(rias)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FRID":
                    if let frid = FRID.create(node) {
                        let fr = FeatureTypeRecord(frid: frid)
                        dsf.addRecord(fr)
                        currentRecord = fr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FOID":
                    if let fr = currentRecord as? FeatureTypeRecord, let foid = FOID.create(node) {
                        fr.foid = foid
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "SPAS":
                    if let fr = currentRecord as? FeatureTypeRecord, let spas = SPAS.create(node) {
                        fr.addSpas(spas)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "INAS":
                    if let record = currentRecord as? RecordWithINAS, let inas = INAS.create(node) {
                        record.addInas(inas)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CCID":
                    if let ccid = CCID.create(node) {
                        let ccr = CompositeCurveRecord(ccid: ccid)
                        dsf.addRecord(ccr)
                        currentRecord = ccr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "CUCO":
                    if let ccr = currentRecord as? CompositeCurveRecord, let cuco = CUCO.create(node) {
                        ccr.addCuco(cuco)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "MRID":
                    if let mrid = MRID.create(node) {
                        let mpr = MultiPointRecord(mrid: mrid)
                        dsf.addRecord(mpr)
                        currentRecord = mpr
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "FASC":
                    if let fr = currentRecord as? FeatureTypeRecord, let fasc = FASC.create(node, validationResult: validationResult) {
                        fr.addFasc(fasc)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                case "MASK":
                    if let fr = currentRecord as? FeatureTypeRecord, let mask = MASK.create(node) {
                        fr.addMask(mask)
                    } else {
                        print("TODO: handle \(node.fieldTag) for \(String(describing: currentRecord))")
                    }
                default:
                    print("TODO: unsupported field tag: \(node.fieldTag)")
                }
            }
        }
        
        return (dsf, validationResult)
    }
    
    
}
