//
//  OrderManager.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-06.
//

import Foundation
import CoreData

struct OrderManager {
    
    let currentOrder: Order

    init?(product: Product) {
        currentOrder = Order(context: CoreDataManager.managedContext)
        currentOrder.identifier = UUID().uuidString
        currentOrder.createdOn = Date()
        currentOrder.addToOrderItems(makeOrderItem(product: product))

        do {
            try CoreDataManager.saveContext()
        } catch {
            print("Error occured on OrderManager initialisation! \(error.localizedDescription)")
            return nil
        }
    }

    func addProductToOrder(product: Product) {
        if let existingOrderItem = orderItem(withProductId: product.identifier) {
            existingOrderItem.quantity += 1
        } else {
            let item = makeOrderItem(product: product)
            currentOrder.addToOrderItems(item)
        }
        try? CoreDataManager.saveContext()
    }
}

// MARK: - Helpers

private extension OrderManager {

    func makeOrderItem(product: Product) -> OrderItem {
        let orderItem = OrderItem(context: CoreDataManager.managedContext)
        orderItem.identifier = UUID().uuidString
        orderItem.quantity = 1
        orderItem.price = product.price
        orderItem.product = product
        return orderItem
    }

    func orderItem(withProductId productId: String?) -> OrderItem? {
        guard
            let productId = productId,
            let oredrItems = currentOrder.orderItems as? Set<OrderItem>
        else {
            return nil
        }

        return oredrItems.first { orderItem in
            orderItem.product?.identifier == productId
        }
    }
    
}
