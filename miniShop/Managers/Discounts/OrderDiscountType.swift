//
//  OrderDiscountType.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-07.
//

import Foundation

struct OrderDiscountType {
    let identifier: String
    let percentage: NSDecimalNumber?
    let amount: NSDecimalNumber?
    let isValid: (Order) -> Bool

    static var amountDiscountBasedOnTotal: OrderDiscountType = {
        return OrderDiscountType(
            identifier: "amountDiscountBasedOnTotal",
            percentage: nil,
            amount: 10,
            isValid: { order in
                guard let orderItems = order.orderItems as? Set<OrderItem> else { return false }
                return orderItems.reduce(0) { $0 + ($1.price?.floatValue ?? 0) } > 50
            }
        )
    }()

    static var percentageDiscountBasedOnMultipleItems: OrderDiscountType = {
        return OrderDiscountType(
            identifier: "percentageDiscountBasedOnMultipleItems",
            percentage: 0.05,
            amount: nil,
            isValid: { order in
                guard let orderItems = order.orderItems as? Set<OrderItem> else { return false }
                return orderItems.count >= 5
            }
        )
    }()
}
