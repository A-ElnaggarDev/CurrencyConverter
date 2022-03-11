//
//  CoverterResponse.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import Foundation

struct CurrecnyRatesModel:  Codable {
    let date: String
    let base: String
    let rates: [String: Double]
    enum CodingKeys: String, CodingKey {
        case date, base, rates
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        base = try container.decode(String.self, forKey: .base)
        rates = try container.decode([String: Double].self, forKey: .rates)
    }
}

extension CurrecnyRatesModel {
    
    func convert(amount: Double, from: String, to: String) -> Double {
        guard let fromRatioRelativeToBase = rates[from] else {
            return 0
        }
        
        guard let toRatioRelativeToBase = rates[to] else {
            return 0
        }
        
        let valueRelativeToBase = amount / fromRatioRelativeToBase // IN EUR
        
        return valueRelativeToBase * toRatioRelativeToBase
    }
}



