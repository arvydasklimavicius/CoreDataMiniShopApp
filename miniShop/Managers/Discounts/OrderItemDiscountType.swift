//
//  OrderItemDiscountType.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-06.
//

import Foundation

struct OrderItemDiscountType {
    let identifier: String
    let percentage: NSDecimalNumber?
    let amount: NSDecimalNumber?
    let filterApplicableItems: (Set<OrderItem>) -> (Set<OrderItem>)
    
    static var threeSameKindProducts: OrderItemDiscountType = {
        return OrderItemDiscountType(
            identifier: "threeSameKindProducts",
            percentage: 10,
            amount: nil,
            filterApplicableItems: { orderItems in
                return orderItems
                    .filter { $0.quantity >= 3
                        && !$0.containsDiscount(withIdentifier: "threeSameKindProducts")
                    }
            }
        )
    }()
    
    static var threeOrMoreDifferentItems: OrderItemDiscountType = {
        return OrderItemDiscountType(
            identifier: "threeOrMoreDifferentItems",
            percentage: nil,
            amount: -2,
            filterApplicableItems: { orderItems in
                if orderItems.count >= 3 {
                    return orderItems.filter {
                        !$0.containsDiscount(withIdentifier: "threeOrMoreDifferentItems")
                    }
                }
                return []
            }
        )
    }()
}
