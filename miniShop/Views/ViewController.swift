//
//  ViewController.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-03-29.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var barcodeTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    lazy var coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addProductTapped(_ sender: Any) {
        do {
            try saveProduct()
            print("Saved")
        } catch {
            print("Error saving product: \(error.localizedDescription)")
        }
    }
    
}

extension ViewController {
    private func saveProduct() throws {
        let product = Product(context: CoreDataManager.managedContext)
        
        product.identifier = UUID().uuidString
        product.productDescription = descriptionTextField.text
        product.barcode = barcodeTextField.text
        product.image = imageTextField.text
        
        if let productName = nameTextField.text,
           let productPrice = priceTextField.text,
           !productName.isEmpty,
           !productPrice.isEmpty
        {
            product.name = productName
            product.price = NSDecimalNumber(string: productPrice)
            
        }
        
        try CoreDataManager.saveContext()
//        product.name = nameTextField.text
//        product.productDescription = descriptionTextField.text
//        product.barcode = barcodeTextField.text
//        product.image = imageTextField.text
//        product.price = Decimal(string: priceTextField.text ?? "0.00") as NSDecimalNumber?
        
//        do {
//            try coreDataManager.managedContext.save()
//                print("Saved")
//        } catch {
//                print("can't save \(error)")
//            }
    }
    
    func showAlert(message: String, onDidDismiss: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Add product",
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "OK", style:.default) { _ in
            onDidDismiss?()
        }
        alert.addAction(alertAction)

        present(alert, animated: true, completion: nil)
    }
}

