//
//  File.swift
//  SwiftS101
//
//  Created by Tore Halset on 22/12/2025.
//

import Foundation

public class DataSetFile {
    
    public var generalInformation: DataSetGeneralInformationRecord?
    public var coordinateReferenceSystem: DataSetCoordinateReferenceSystemRecord?
    
    private var recordByIdentifier: [RecordIdentifier: Record] = [:]
    
    public func addRecord(_ record: Record) {
        recordByIdentifier[record.recordIdentifier()] = record
    }
    
}
