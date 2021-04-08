//
//  OrderItemDiscount+CoreDataProperties.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-08.
//
//

import Foundation
import CoreData


extension OrderItemDiscount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItemDiscount> {
        return NSFetchRequest<OrderItemDiscount>(entityName: "OrderItemDiscount")
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var identifier: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var percentage: NSDecimalNumber?
    @NSManaged public var orderitem: NSSet?

}

// MARK: Generated accessors for orderitem
extension OrderItemDiscount {

    @objc(addOrderitemObject:)
    @NSManaged public func addToOrderitem(_ value: OrderItem)

    @objc(removeOrderitemObject:)
    @NSManaged public func removeFromOrderitem(_ value: OrderItem)

    @objc(addOrderitem:)
    @NSManaged public func addToOrderitem(_ values: NSSet)

    @objc(removeOrderitem:)
    @NSManaged public func removeFromOrderitem(_ values: NSSet)

}

extension OrderItemDiscount : Identifiable {

}
