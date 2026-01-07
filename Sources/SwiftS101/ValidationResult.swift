//
//  File.swift
//  swift-s101
//

import Foundation

public class ValidationResult {
    
    private var _warnings: [String] = []
    
    func addWarning(_ message: String) {
        _warnings.append(message)
    }
    
    func warnings() -> [String] {
        let copy = _warnings
        return copy
    }
    
}
