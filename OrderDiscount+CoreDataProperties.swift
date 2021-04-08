//
//  OrderDiscount+CoreDataProperties.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-08.
//
//

import Foundation
import CoreData


extension OrderDiscount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderDiscount> {
        return NSFetchRequest<OrderDiscount>(entityName: "OrderDiscount")
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var identifier: String?
    @NSManaged public var orderDiscountDescription: String?
    @NSManaged public var percentage: NSDecimalNumber?
    @NSManaged public var order: NSSet?

}

// MARK: Generated accessors for order
extension OrderDiscount {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: Order)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: Order)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}

extension OrderDiscount : Identifiable {

}
