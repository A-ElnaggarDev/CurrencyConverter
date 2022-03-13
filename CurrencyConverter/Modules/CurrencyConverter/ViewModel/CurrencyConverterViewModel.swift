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
    
    //MARK: - Variables
    var model: CurrecnyRatesModel?
    let disposebag = DisposeBag()
    // Input
    var fromCurrencyRelay = PublishRelay<String>.init()
    var toCurrencyRelay = PublishRelay<String>.init()
    var fromAmountRelay = PublishRelay<Double>.init()
    var toAmountRelay = PublishRelay<Double>.init()
    var isLoadingSubject = BehaviorSubject<Bool>(value: true)
    var errorSubject = PublishSubject<Error>()
    var networkConnectionSubject = BehaviorSubject<Bool>(value: true)
//    var isLoadingRelay = PublishRelay<Bool>.init()
//    var errorRelay = PublishRelay<Error>.init()
    
    // Output
    var toCurrencyOutPutRelay = PublishRelay<String>.init()
    var fromCurrencyOutPutRelay = PublishRelay<String>.init()
    var placeholderOutputRelay = PublishRelay<String>.init()
    
    init() {
        setupBinding()
    }
    
    
    private func setupBinding() {
        let fromObserable = Observable.combineLatest(fromAmountRelay, fromCurrencyRelay, toCurrencyRelay)
        fromObserable.subscribe(onNext: { [weak self] (amount, from, to) in
            guard let self = self, let model = self.model else { return }
            let convertedAmount = model.convert(amount: amount, from: from, to: to)
            self.toCurrencyOutPutRelay.accept(String.init(convertedAmount))
        }).disposed(by: disposebag)
        
        let toObserable = Observable.combineLatest(toAmountRelay, toCurrencyRelay, fromCurrencyRelay)
        toObserable.subscribe(onNext: { [weak self] (amount, from, to) in
            guard let self = self, let model = self.model else { return }
            let convertedAmount = model.convert(amount: amount, from: from, to: to)
            self.fromCurrencyOutPutRelay.accept(String.init(convertedAmount))
        }).disposed(by: disposebag)
        
        Observable.combineLatest(fromCurrencyRelay, toCurrencyRelay).subscribe(onNext: { [weak self] (from, to) in
            guard let self = self, let model = self.model else { return }
            let amount = model.convert(amount: 1, from: from, to: to)
            self.placeholderOutputRelay.accept(String.init(amount))
        }).disposed(by: disposebag)
        
    }
    
    func checkNetworkConnection() {
        APIClient.checkNetworkConnection { success in
            if success {
                self.initialize()
            } else {
                self.isLoadingSubject.onNext(false)
                self.networkConnectionSubject.onNext(false)
            }
        }
    }
    
    func initialize() {
        self.isLoadingSubject.onNext(true)
        APIClient.fetchCurrencies().subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            self.isLoadingSubject.onNext(false)
            self.model = model
            self.fromCurrencyRelay.accept(model.base)
            self.toCurrencyRelay.accept(model.base)
        }, onError: { error in
//            if error is NetworkError.noInternetConnection {
//                
//            }
            self.isLoadingSubject.onNext(false)
            self.errorSubject.onNext(error)
            
        }).disposed(by: disposebag)
    }
    
    
    
}
