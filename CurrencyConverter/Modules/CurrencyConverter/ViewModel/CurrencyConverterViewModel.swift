//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import Foundation
import RxSwift

class CurrencyConverterViewModel {
    
    let currencies = BehaviorSubject<[CurrencyModel]>(value: [])
    
    func fetchCurrencies() {
        APIClient.fetchCurrencies { [weak self] (currencyRate) in
            self!.currencies.onNext(currencyRate!.rates.map({.init(code: $0.key, valueRelativeToBase: $0.value)}))
        }
    }
}
