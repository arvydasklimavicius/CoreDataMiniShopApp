//
//  OrderItem+CoreDataProperties.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-08.
//
//

import Foundation
import CoreData


extension OrderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItem> {
        return NSFetchRequest<OrderItem>(entityName: "OrderItem")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var quantity: Int16
    @NSManaged public var vatRate: NSDecimalNumber?
    @NSManaged public var discounts: NSSet?
    @NSManaged public var order: NSSet?
    @NSManaged public var product: Product?

}

// MARK: Generated accessors for discounts
extension OrderItem {

    @objc(addDiscountsObject:)
    @NSManaged public func addToDiscounts(_ value: OrderItemDiscount)

    @objc(removeDiscountsObject:)
    @NSManaged public func removeFromDiscounts(_ value: OrderItemDiscount)

    @objc(addDiscounts:)
    @NSManaged public func addToDiscounts(_ values: NSSet)

    @objc(removeDiscounts:)
    @NSManaged public func removeFromDiscounts(_ values: NSSet)

}

// MARK: Generated accessors for order
extension OrderItem {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: Order)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: Order)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}

extension OrderItem : Identifiable {

}
