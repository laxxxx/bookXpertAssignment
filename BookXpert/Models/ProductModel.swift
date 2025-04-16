//
//  ProductModel.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import Foundation

struct Product: Codable {
    let id: String
    let name: String
    let data: [String: ProductDataValue]?
}

enum ProductDataValue: Codable {
    case string(String)
    case int(Int)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let val = try? container.decode(String.self) {
            self = .string(val)
        } else if let val = try? container.decode(Double.self) {
            self = .double(val)
        } else if let val = try? container.decode(Int.self) {
            self = .int(val)
        } else {
            throw DecodingError.typeMismatch(ProductDataValue.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid value"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let str): try container.encode(str)
        case .int(let intVal): try container.encode(intVal)
        case .double(let doubleVal): try container.encode(doubleVal)
        }
    }

    var description: String {
        switch self {
        case .string(let str): return str
        case .int(let intVal): return "\(intVal)"
        case .double(let doubleVal): return "\(doubleVal)"
        }
    }
}
