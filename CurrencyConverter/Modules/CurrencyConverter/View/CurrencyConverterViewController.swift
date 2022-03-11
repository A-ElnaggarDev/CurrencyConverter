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

//MARK:- variables
    lazy var viewModel: CurrencyConverterViewModel = {
        return CurrencyConverterViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency Converter"
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
