//
//  BaseViewController.swift
//  CurrencyConverter
//
//  Created by maika on 11/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
// MARK: - Variables
    let disposeBag = DisposeBag()

    
    // MARK: - LifeCycle
    deinit {
        print("\(type(of: self)) dinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModelToViews()
        bindViewsToViewModel()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {}
    func bindViewModelToViews() {}
    func bindViewsToViewModel() {}
}
