//
//  CartManager.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-03-31.
//

import Foundation
import CoreData

final class CartManager {

    var orderManager: OrderManager?

    func getOrderItems() -> Set<OrderItem>? {
        return orderManager?.currentOrder.orderItems as? Set<OrderItem>
    }

    func addProductToCart(_ product: Product) {
        guard let manager = orderManager else {
            orderManager = OrderManager(product: product)
            return
        }
        manager.addProductToOrder(product: product)
        DiscountManager.applyDiscounts(order: manager.currentOrder)
        recalculatePrices()
    }

    func calculateCartTotal() -> NSDecimalNumber {
        guard let orderItems = orderManager?.currentOrder.orderItems as? Set<OrderItem> else {
            return .zero
        }

        let orderItemsTotal = orderItems.reduce(NSDecimalNumber.zero) { $0.adding($1.price ?? .zero) }

        guard
            let orderDiscounts = orderManager?.currentOrder.orderDiscounts as? Set<OrderDiscount>,
            !orderDiscounts.isEmpty
        else {
            return orderItemsTotal
        }

        var orderDiscountsTotal: NSDecimalNumber = 0

        for discount in orderDiscounts {
            if let percentage = discount.percentage {
                orderDiscountsTotal = orderDiscountsTotal.adding(orderItemsTotal.multiplying(by: percentage))
            } else if let amount = discount.amount {
                orderDiscountsTotal = orderDiscountsTotal.adding(amount)
            }
        }

        let orderTotal = orderItemsTotal.subtracting(orderDiscountsTotal).doubleValue
        return NSDecimalNumber(floatLiteral: max(orderTotal, .zero))
    }
}

// MARK: - Private functionality

private extension CartManager {

    func recalculatePrices() {
        guard let orderItems = orderManager?.currentOrder.orderItems as? Set<OrderItem> else { return }

        for orderItem in orderItems {
            var totalDiscountAmount: NSDecimalNumber = 0

            let orderItemQuantity = NSDecimalNumber(value: Int(orderItem.quantity))
            let orderItemPrice = orderItem.product?.price?.multiplying(by: orderItemQuantity)

            if let discounts = orderItem.discounts as? Set<OrderItemDiscount> {
                for discount in discounts {
                    if
                        let percentage = discount.percentage,
                        let discountAmount = orderItemPrice?.multiplying(by: percentage)
                    {
                        totalDiscountAmount = totalDiscountAmount.adding(discountAmount)
                    } else if let amount = discount.amount {
                        totalDiscountAmount = totalDiscountAmount.adding(amount)
                    }
                }
            }

            let newOrderItemPrice = orderItemPrice?.subtracting(totalDiscountAmount).doubleValue ?? 0
            orderItem.price = NSDecimalNumber(floatLiteral: max(newOrderItemPrice, .zero))
        }
        try? CoreDataManager.saveContext()
    }
}
