//
//  File.swift
//  swift-s101
//

import Foundation

public class ValidationResult {
    
    private var messages: [ValidationMessage] = []
    
    public enum ValidationMessageLevel: Int {
        case warning = 1
        case error = 2
    }
    
    func addWarning(_ message: String) {
        addWarning(fileName: nil, message: message)
    }
    
    func addWarning(fileName: String?, message: String) {
        addMessage(level: .warning, fileName: fileName, message: message)
    }

    func addError(_ message: String) {
        addError(fileName: nil, message: message)
    }
    
    func addError(fileName: String?, message: String) {
        addMessage(level: .error, fileName: fileName, message: message)
    }
    
    func addMessage(level: ValidationMessageLevel, fileName: String?, message: String) {
        switch level {
        case .warning:
            print("WARNING: \(String(describing: fileName)) \(message)")
        case .error:
            print("ERROR: \(String(describing: fileName)) \(message)")
        }
        messages.append(.init(level: level, fileName: fileName, message: message))
    }
    
    func warnings() -> [String] {
        return messages.filter { $0.level == .warning }.map( { $0.message })
    }
    
    func errors() -> [String] {
        return messages.filter { $0.level == .error }.map( { $0.message })
    }
    
    public struct ValidationMessage {
        
        public let level: ValidationMessageLevel
        public let fileName: String?
        public let message: String
        
    }
    
}
