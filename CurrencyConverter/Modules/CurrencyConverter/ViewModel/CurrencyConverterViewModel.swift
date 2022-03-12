//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import Foundation
import RxSwift
import RxRelay

class CurrencyConverterViewModel {
    
    let disposebag = DisposeBag()
    //MARK: - Input
    var fromCurrencyRelay = PublishRelay<String>.init()
    var toCurrencyRelay = PublishRelay<String>.init()
    var fromAmountRelay = PublishRelay<Double>.init()
    var toAmountRelay = PublishRelay<Double>.init()
    var isLoadingRelay = PublishRelay<Bool>.init()
    var errorRelay = PublishRelay<Error>.init()
    //MARK: - Output
    var toCurrencyOutPut = PublishRelay<String>.init()
    var fromCurrencyOutPut = PublishRelay<String>.init()
    var placeholderOutputRelay = PublishRelay<String>.init()
    
    init() {
        setupBinding()
    }
    
    private func setupBinding() {
        let fromObserable = Observable.combineLatest(fromAmountRelay, fromCurrencyRelay, toCurrencyRelay)
        fromObserable.subscribe(onNext: { [weak self] (amount, from, to) in
            guard let self = self, let model = self.model else { return }
            let convertedAmount = model.convert(amount: amount, from: from, to: to)
            self.toCurrencyOutPut.accept(String.init(convertedAmount))
        }).disposed(by: disposebag)
        
        let toObserable = Observable.combineLatest(toAmountRelay, toCurrencyRelay, fromCurrencyRelay)
        toObserable.subscribe(onNext: { [weak self] (amount, from, to) in
            guard let self = self, let model = self.model else { return }
            let convertedAmount = model.convert(amount: amount, from: from, to: to)
            self.fromCurrencyOutPut.accept(String.init(convertedAmount))
        }).disposed(by: disposebag)
        
        Observable.combineLatest(fromCurrencyRelay, toCurrencyRelay).subscribe(onNext: { [weak self] (from, to) in
            guard let self = self, let model = self.model else { return }
            let amount = model.convert(amount: 1, from: from, to: to)
            self.placeholderOutputRelay.accept(String.init(amount))
        }).disposed(by: disposebag)
        
    }
    
    var model: CurrecnyRatesModel?
    
    func initialize() {
        APIClient.fetchCurrencies().subscribe(onNext: { model in
            self.model = model
            self.fromCurrencyRelay.accept(model.base)
            self.toCurrencyRelay.accept(model.base)
        }, onError: { error in
            self.errorRelay.accept(error)
            
        }).disposed(by: disposebag)
    }
    
    
}
