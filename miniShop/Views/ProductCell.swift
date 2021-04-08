//
//  ProductCell.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-03-30.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureCell(name: String, price: NSDecimalNumber) {
        productNameLabel.text = name
        priceLabel.text = price.stringValue + " $"
        
        selectionStyle = .none
    }

}
