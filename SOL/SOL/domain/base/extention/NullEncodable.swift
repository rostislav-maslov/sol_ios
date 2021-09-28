//
//  NullEncodable.swift
//  SOL
//
//  Created by Rostislav Maslov on 28.09.2021.
//

import Foundation

@propertyWrapper
struct NullEncodable<T>: Codable where T: Codable {
    
    var wrappedValue: T?

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case .some(let value): try container.encode(value)
        case .none: try container.encodeNil()
        }
    }
}
