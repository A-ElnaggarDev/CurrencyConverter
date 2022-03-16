//
//  CurrencyConverterViewModelTest.swift
//  CurrencyConverterTests
//
//  Created by maika on 15/03/2022.
//

import XCTest
import RxSwift
import RxRelay

@testable import CurrencyConverter

class CurrencyConverterViewModelTest: XCTestCase {

    var sut: CurrencyConverterViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        sut = CurrencyConverterViewModel(interacor: CurrencyConverterMockInteractor())
        disposeBag = DisposeBag()
        
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        disposeBag = nil
    }
    
    func testCurrencyConverterViewModel_whenStart_loadRatesModelDate() {
        sut.initialize()
        XCTAssertEqual(sut.model?.date, "2022-03-15")
    }
    
    func testCurrencyConverterViewModel_whenConvertFromEUR_canConvertCurrency() {
            sut.initialize()
            sut.fromCurrencyRelay.accept("EUR")
            sut.toCurrencyRelay.accept("USD")
            var result: String?
            let expected = expectation(description: "currency converting")
            sut.toCurrencyOutPutRelay.subscribe(onNext: { string in
                result = string
                expected.fulfill()
            }).disposed(by: disposeBag)
            sut.fromAmountRelay.accept(100)
            
            wait(for: [expected], timeout: 4)
            XCTAssertEqual(result, "109.4164")
        }
        
        func testCurrencyConverterViewModel_whenConvertFromAny_canConvertCurrency() {
            sut.initialize()
            sut.fromCurrencyRelay.accept("USD")
            sut.toCurrencyRelay.accept("EGP")
            var result: String?
            let expected = expectation(description: "currency converting")
            sut.toCurrencyOutPutRelay.subscribe(onNext: { string in
                result = string
                expected.fulfill()
            }).disposed(by: disposeBag)
            sut.fromAmountRelay.accept(100)
            
            wait(for: [expected], timeout: 4)
            XCTAssertEqual(result, "1571.239503401684")
        }

}
