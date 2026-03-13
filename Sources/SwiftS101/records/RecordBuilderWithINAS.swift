//
//  File.swift
//  swift-s101
//

import Foundation

protocol RecordBuilderWithINAS: RecordBuilderWithVersion {
    
    func addInas(_ inas: INAS)
    
}
