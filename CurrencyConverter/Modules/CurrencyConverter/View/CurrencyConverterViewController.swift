//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyConverterViewController: BaseViewController {

//MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var swapCurrenciesButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var detailsButton: UIButton!
    
//MARK: - Variables
    let viewModel = CurrencyConverterViewModel()

    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency Converter"
    }
//MARK: - Functions
    override func setupView() {
        super.setupView()
        viewModel.checkNetworkConnection()
//        viewModel.initialize()
    }
    
    override func bindViewModelToViews() {
        super.bindViewModelToViews()
        viewModel.fromCurrencyOutPutRelay.bind(to: fromTextField.rx.text).disposed(by: disposeBag)
        
        viewModel.toCurrencyOutPutRelay.bind(to: toTextField.rx.text).disposed(by: disposeBag)
        
        viewModel.placeholderOutputRelay.bind(to: toTextField.rx.placeholder).disposed(by: disposeBag)
        
        viewModel.fromCurrencyRelay.bind(to: fromButton.rx.title(for: .normal)).disposed(by: disposeBag)
        
        viewModel.toCurrencyRelay.bind(to: toButton.rx.title(for: .normal)).disposed(by: disposeBag)
        
        viewModel.isLoadingSubject.asDriver(onErrorJustReturn: false).drive(activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        viewModel.enableUserActionSubject.asDriver(onErrorJustReturn: false).drive(toButton.rx.isEnabled, fromButton.rx.isEnabled, detailsButton.rx.isEnabled, swapCurrenciesButton.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.networkConnectionSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (connected) in
            guard let self = self else { return }
            if !connected {
                self.show(messageAlert: "Network Error", message: "Connect To Network")
            }
        }).disposed(by: disposeBag)
        viewModel.errorSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let self = self else { return }
            self.show(messageAlert: "Service Error", message: error.localizedDescription)
        }).disposed(by: disposeBag)
        
    }
    
    override func bindViewsToViewModel() {
        super.bindViewsToViewModel()
        fromTextField.rx
            .text
            .orEmpty
            .compactMap(Double.init)
            .bind(to: viewModel.fromAmountRelay)
            .disposed(by: disposeBag)
        
        toTextField.rx
            .text
            .orEmpty
            .compactMap(Double.init)
            .bind(to: viewModel.toAmountRelay)
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - Actions
    @IBAction func fromCurrencyClicked(_ sender: Any) {
        let source = viewModel.model?.rates.map(\.key) ?? []
        selectItem(title: "Select Currency", source: source) { currencyCode in
            self.viewModel.fromCurrencyRelay.accept(currencyCode)
        }
    }
    
    @IBAction func toCurrencyClicked(_ sender: Any) {
        let source = viewModel.model?.rates.map(\.key) ?? []
        selectItem(title: "Select Currency", source: source) { currencyCode in
            self.viewModel.toCurrencyRelay.accept(currencyCode)
        }
    }
    
    @IBAction func swapCurrenciesClicked(_ sender: Any) {
        let fromTitle = fromButton.title(for: .normal)
        let toTitle = toButton.title(for: .normal)
        viewModel.fromCurrencyRelay.accept(toTitle ?? "EUR")
        viewModel.toCurrencyRelay.accept(fromTitle ?? "EUR")
    }
    
    @IBAction func detailsButtonClicked(_ sender: Any) {
        let controller = OtherCurrenciesViewController(baseCurrency: fromButton.titleLabel!.text ?? "", model: viewModel.model!, baseCurrencyAmount: fromTextField.text ?? "")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


