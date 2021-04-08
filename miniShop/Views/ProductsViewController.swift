//
//  ProductsViewController.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-03-29.
//

import UIKit
import CoreData

class ProductsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var cartManager: CartManager?
    private var products = [Product]()
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.tableFooterView = UIView()
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard
            let productCell = cell as? ProductCell,
              products.count > indexPath.row,
              let name = products[indexPath.row].name,
              let price = products[indexPath.row].price
        else {
            return cell
        }
        productCell.configureCell(name: name, price: price)
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addProductToCart(product: products[indexPath.row])
    }
}

extension ProductsViewController {
    
    func fetchProducts() {
        do {
            products = try ProductsManager.getProducts()
        } catch {
            print("Error while fetchingProducts managed object context \(error.localizedDescription)")
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addProductToCart(product: Product) {
        if let cartManager = cartManager {
            cartManager.addProductToCart(product)
            print("\(product.name!) added to cart")
        } else {
            print("Error while adding to cart!")
        }
    }
    
//    private func addProduct(product: Product) {
//
//        let productIdentifier = product.identifier ?? ""
//
//        if let existingOrderItem = orderItem(withProductId: productIdentifier) {
//            existingOrderItem.quantity += 1
//        } else {
//            let orderItem = OrderItem(context: coreDataManager.managedContext)
//            orderItem.identifier = UUID().uuidString
//            orderItem.quantity = 1
//            orderItem.price = product.price
//            orderItem.product = product
//        }
//
//        do {
//            try coreDataManager.saveContext()
////            CartManager.orderItems.append(orderItem)
//            print("Product added to cart: \(product.name!)")
//        } catch {
//            print("Error saving add to cart managedContext \(error.localizedDescription)")
//        }
//
//        print(getOrderItem().map { "\($0.product?.name) \($0.quantity)"})
//
//    }
    
//    private func getOrderItem() -> [OrderItem] {
//        let fetchRequest: NSFetchRequest<OrderItem> = OrderItem.fetchRequest()
//
//        do {
//            let orderItem = try coreDataManager.managedContext.fetch(fetchRequest)
//            return orderItem
//        } catch {
//            print("Erro while fetching orderItem managed context \(error.localizedDescription)")
//        }
//        return []
//    }
//
//    private func orderItem(withProductId productId: String) -> OrderItem? {
//
//        let orderItems = getOrderItem()
//
//        for orderItem in orderItems {
//            if orderItem.product?.identifier == productId {
//                return orderItem
//            }
//        }
//        return nil
//    }
}

