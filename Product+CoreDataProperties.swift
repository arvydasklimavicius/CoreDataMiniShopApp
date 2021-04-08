//
//  Product+CoreDataProperties.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-04-08.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var barcode: String?
    @NSManaged public var identifier: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var productDescription: String?
    @NSManaged public var orderItem: NSSet?

}

// MARK: Generated accessors for orderItem
extension Product {

    @objc(addOrderItemObject:)
    @NSManaged public func addToOrderItem(_ value: OrderItem)

    @objc(removeOrderItemObject:)
    @NSManaged public func removeFromOrderItem(_ value: OrderItem)

    @objc(addOrderItem:)
    @NSManaged public func addToOrderItem(_ values: NSSet)

    @objc(removeOrderItem:)
    @NSManaged public func removeFromOrderItem(_ values: NSSet)

}

extension Product : Identifiable {

}
