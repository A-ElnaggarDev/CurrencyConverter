//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import Foundation

struct CurrencyErrorModel: Decodable {
    let success: Bool
    let error: ErrorData
}

struct ErrorData: Decodable {
    let type: String
}

extension ErrorData: LocalizedError {
    var errorDescription: String? {
        return type
    }
}
