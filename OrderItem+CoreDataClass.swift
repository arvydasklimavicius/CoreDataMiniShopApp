//
//  OrderItem+CoreDataClass.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-03-29.
//
//

import Foundation
import CoreData

@objc(OrderItem)
public class OrderItem: NSManagedObject {
    func containsDiscount(withIdentifier identifier: String) -> Bool {
        guard let discounts = discounts as? Set<OrderItemDiscount> else {
            return false
        }
        
        return discounts.contains { discount in
            return discount.identifier == identifier
        }
    }
}
