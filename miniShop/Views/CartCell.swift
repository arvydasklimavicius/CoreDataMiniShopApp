//
//  CartCell.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-07.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func configureCell(name: String, quantity: Int, price: NSDecimalNumber) {
        productNameLabel.text = "\(quantity) \(name)"
        productPriceLabel.text = price.stringValue
        
        selectionStyle = .none
    }
    

}
