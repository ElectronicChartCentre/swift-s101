//
//  File.swift
//  swift-s101
//

import Foundation

public struct DataSetFileUpdater {
    
    public static func update(base: DataSetFileBuilder, update: DataSetFileBuilder, updateFileName: String, validationResult: ValidationResult) {
        
        for updateRecord in update.records() {
            guard let updateRecord = updateRecord as? RecordBuilderWithVersion else {
                print("TODO: handle non-versioned record type: \(type(of:updateRecord))")
                continue
            }
            
            let updateRecordVersion = updateRecord.recordVersion()
            
            switch updateRecordVersion.ruin {
            case RecordVersion.ruinInsert:
                // TODO: check that record does not exist before add
                base.addRecord(updateRecord)
            case RecordVersion.ruinDelete:
                // TODO: check that record does exist before remove
                base.removeRecord(updateRecord.recordIdentifier())
            case RecordVersion.ruinModify:
                if let baseRecord = base.record(forIdentifier: updateRecord.recordIdentifier()) as? any RecordBuilderWithVersion {

                    if baseRecord.recordVersion().rver != updateRecordVersion.rver - 1 {
                        validationResult.addError(fileName: updateFileName, message: "rver mismatch")
                    }
                    
                    if let updatedRecord = baseRecord.applyModify(update: updateRecord) {
                        base.replaceRecord(updatedRecord)
                    } else {
                        validationResult.addError(fileName: updateFileName, message: "could not update record")
                    }
                } else {
                    validationResult.addError(fileName: updateFileName, message: "ruin modify, but could not find original record")
                }
            default:
                print("TODO: handle versioned record type: \(type(of:updateRecord)) with \(updateRecordVersion)")
            }
            
        }
        
    }
    
}
