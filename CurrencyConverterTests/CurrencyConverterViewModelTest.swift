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
    
    

}
