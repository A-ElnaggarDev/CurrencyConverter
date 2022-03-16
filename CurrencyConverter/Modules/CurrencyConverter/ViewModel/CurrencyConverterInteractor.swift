//
//  CurrencyConverterInteractor.swift
//  CurrencyConverter
//
//  Created by maika on 15/03/2022.
//

import Foundation
import RxSwift

class CurrencyConverterInteractor: CurrencyConverterInteractorProtocol {
    func fetchCurrencies() -> Observable<CurrecnyRatesModel> {
        return APIClient.fetchCurrencies()
    }
}

protocol CurrencyConverterInteractorProtocol {
    func fetchCurrencies() -> Observable<CurrecnyRatesModel>
}
