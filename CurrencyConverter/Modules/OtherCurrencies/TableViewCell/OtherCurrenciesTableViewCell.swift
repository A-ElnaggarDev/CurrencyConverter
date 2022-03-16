//
//  OtherCurrenciesTableViewCell.swift
//  CurrencyConverter
//
//  Created by maika on 13/03/2022.
//

import UIKit

class OtherCurrenciesTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyCodeLable: UILabel!
    @IBOutlet weak var ValueRelativeToBaseLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
