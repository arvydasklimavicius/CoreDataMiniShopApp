//
//  DiscountManager.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-05.
//

import Foundation
import CoreData

struct DiscountManager {

    static func applyDiscounts(order: Order) {
        DiscountManager.applyOrderItemDiscounts(orderItems: order.orderItems as? Set<OrderItem>)
        DiscountManager.applyOrderDiscounts(order: order)
    }

    // MARK: - Order item discount functionality

    static func applyOrderItemDiscounts(orderItems: Set<OrderItem>?) {
        guard let orderItems = orderItems else { return }

        let discountTypes: [OrderItemDiscountType] = [
            .threeOrMoreDifferentItems,
            .threeSameKindProducts
        ]
        
        for discountType in discountTypes {
            let applicableItems = discountType.filterApplicableItems(orderItems)
            let orderItemDiscount = getOrderItemDiscount(by: discountType)
            
            for applicableItem in applicableItems {
                applicableItem.addToDiscounts(orderItemDiscount)
                
            }
        }
        
        do {
            try CoreDataManager.saveContext()
        } catch {
            print("Error saving order item discounts")
        }
    }
    
    private static func getOrderItemDiscount(by type: OrderItemDiscountType) -> OrderItemDiscount {
        let discounts = getOrderItemDiscounts()
        
        if let discount = discounts.first(where: { $0.identifier == type.identifier }) {
            return discount
        }
        
        let discount = OrderItemDiscount(context: CoreDataManager.managedContext)
        discount.identifier = type.identifier
        discount.percentage = type.percentage
        discount.amount = type.amount
        
        try? CoreDataManager.saveContext()
        
        return discount
    }
    
    private static func getOrderItemDiscounts() -> [OrderItemDiscount] {
        let fetchRequest: NSFetchRequest<OrderItemDiscount> = OrderItemDiscount.fetchRequest()

        do {
            return try CoreDataManager.managedContext.fetch(fetchRequest)
        } catch {
            print("Problem fetching order item discounts")
            return []
        }
    }

    // MARK: - Order discount functionality

    static func applyOrderDiscounts(order: Order) {
        let discountTypes: [OrderDiscountType] = [
            .amountDiscountBasedOnTotal,
            .percentageDiscountBasedOnMultipleItems
        ]

        for discountType in discountTypes where discountType.isValid(order) {
            let orderDiscount = getOrderDiscount(by: discountType)
            order.addToOrderDiscounts(orderDiscount)
        }

        do {
            try CoreDataManager.saveContext()
        } catch {
            print("Error saving discounts")
        }
    }

    private static func getOrderDiscount(by type: OrderDiscountType) -> OrderDiscount {
        let discounts = getOrderDiscounts()

        if let discount = discounts.first(where: { $0.identifier == type.identifier }) {
            return discount
        }

        let discount = OrderDiscount(context: CoreDataManager.managedContext)
        discount.identifier = type.identifier
        discount.percentage = type.percentage
        discount.amount = type.amount

        try? CoreDataManager.saveContext()

        return discount
    }

    private static func getOrderDiscounts() -> [OrderDiscount] {
        let fetchRequest: NSFetchRequest<OrderDiscount> = OrderDiscount.fetchRequest()

        do {
            return try CoreDataManager.managedContext.fetch(fetchRequest)
        } catch {
            print("Problem fetching order discounts")
            return []
        }
    }
}
