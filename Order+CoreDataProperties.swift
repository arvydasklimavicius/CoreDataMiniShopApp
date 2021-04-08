//
//  Order+CoreDataProperties.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-08.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var createdOn: Date?
    @NSManaged public var identifier: String?
    @NSManaged public var orderDiscounts: NSSet?
    @NSManaged public var orderItems: NSSet?

}

// MARK: Generated accessors for orderDiscounts
extension Order {

    @objc(addOrderDiscountsObject:)
    @NSManaged public func addToOrderDiscounts(_ value: OrderDiscount)

    @objc(removeOrderDiscountsObject:)
    @NSManaged public func removeFromOrderDiscounts(_ value: OrderDiscount)

    @objc(addOrderDiscounts:)
    @NSManaged public func addToOrderDiscounts(_ values: NSSet)

    @objc(removeOrderDiscounts:)
    @NSManaged public func removeFromOrderDiscounts(_ values: NSSet)

}

// MARK: Generated accessors for orderItems
extension Order {

    @objc(addOrderItemsObject:)
    @NSManaged public func addToOrderItems(_ value: OrderItem)

    @objc(removeOrderItemsObject:)
    @NSManaged public func removeFromOrderItems(_ value: OrderItem)

    @objc(addOrderItems:)
    @NSManaged public func addToOrderItems(_ values: NSSet)

    @objc(removeOrderItems:)
    @NSManaged public func removeFromOrderItems(_ values: NSSet)

}

extension Order : Identifiable {

}
