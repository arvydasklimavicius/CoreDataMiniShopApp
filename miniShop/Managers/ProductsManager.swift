//
//  ProductsManager.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-06.
//

import Foundation
import CoreData

struct ProductsManager {
  
    static func getProducts() throws -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()

        return try CoreDataManager.managedContext.fetch(fetchRequest)
    }
}
