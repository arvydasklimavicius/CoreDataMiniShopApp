//
//  CartViewController.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-07.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var orderItems = [OrderItem]()
    var cartManager: CartManager?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    private func loadData() {
        guard let items = cartManager?.getOrderItems() else { return }
        orderItems = Array(items)
        tableView.reloadData()
    }

}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath)
        
        guard let cartCell = cell as? CartCell,
              let name = orderItems[indexPath.row].product?.name,
              let price = orderItems[indexPath.row].price
        else {
            return cell
        }
        
        let quantity = orderItems[indexPath.row].quantity
        cartCell.configureCell(name: name,
                               quantity: Int(quantity),
                               price: price)
        
        return cartCell
    }
    
    
}

extension CartViewController: UITableViewDelegate {
    
}
