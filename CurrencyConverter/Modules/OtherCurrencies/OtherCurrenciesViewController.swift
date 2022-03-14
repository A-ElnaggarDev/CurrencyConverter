//
//  OtherCurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by maika on 13/03/2022.
//

import UIKit

class OtherCurrenciesViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var currencyBaseLable: UILabel!
    @IBOutlet weak var otherCurrencyTableView: UITableView!
    
    
    //MARK: - Variables
    let baseCurrency: String
    let model: CurrecnyRatesModel
    let baseCurrencyAmount: String
    private let identifier = "OtherCurrenciesTableViewCell"
    
    //MARK: - LifeCycle
    
    init(baseCurrency: String, model: CurrecnyRatesModel, baseCurrencyAmount: String) {
        self.baseCurrency = baseCurrency
        self.model = model
        self.baseCurrencyAmount = baseCurrencyAmount
        super.init(nibName: "OtherCurrenciesViewController", bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Functions
    override func setupView() {
        super.setupView()
        currencyBaseLable.text = baseCurrencyAmount + " " + baseCurrency
        otherCurrencyTableView.register(UINib.init(nibName: identifier, bundle: nibBundle), forCellReuseIdentifier: identifier)
        otherCurrencyTableView.delegate = self
        otherCurrencyTableView.dataSource = self
    }
    
    private func configureCell(row: Int, model: CurrecnyRatesModel, cell: UITableViewCell) -> UITableViewCell {
        guard let cell = cell as? OtherCurrenciesTableViewCell else { return cell }
        let source = model.rates.map(\.key)
        cell.currencyCodeLable.text = source[row]
        cell.ValueRelativeToBaseLable.text = String.init(model.convert(amount: Double.init(self.baseCurrencyAmount) ?? 1, from: baseCurrency, to: source[row]))
        return cell
    }
}

extension OtherCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! OtherCurrenciesTableViewCell
        return configureCell(row: indexPath.row, model: model, cell: cell)
    }
    
    
}
