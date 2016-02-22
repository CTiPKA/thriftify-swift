//
//  TFRecipient.generated.swift
//
//  This code was generated by AlecrimCoreData code generator tool.
//
//  Changes to this file may cause incorrect behavior and will be lost if
//  the code is regenerated.
//

import Foundation
import CoreData

import AlecrimCoreData

// MARK: - TFRecipient properties

extension TFRecipient {

    @NSManaged var address: NSString?
    @NSManaged var identifier: NSString?
    @NSManaged var name: NSString?

    @NSManaged var transactions: NSSet

}

// MARK: - TFRecipient KVC compliant to-many accessors and helpers

extension TFRecipient {

    @NSManaged private func addTransactionsObject(object: TFTransaction)
    @NSManaged private func removeTransactionsObject(object: TFTransaction)
    @NSManaged func addTransactions(transactions: NSSet)
    @NSManaged func removeTransactions(transactions: NSSet)

    func addTransaction(transaction: TFTransaction) { self.addTransactionsObject(transaction) }
    func removeTransaction(transaction: TFTransaction) { self.removeTransactionsObject(transaction) }

}

// MARK: - TFRecipient query attributes

extension TFRecipient {

    static let address = AlecrimCoreData.NullableAttribute<NSString>("address")
    static let identifier = AlecrimCoreData.NullableAttribute<NSString>("identifier")
    static let name = AlecrimCoreData.NullableAttribute<NSString>("name")

    static let transactions = AlecrimCoreData.Attribute<NSSet>("transactions")

}

// MARK: - AttributeType extensions

extension AlecrimCoreData.AttributeType where Self.ValueType: TFRecipient {

    var address: AlecrimCoreData.NullableAttribute<NSString> { return AlecrimCoreData.NullableAttribute<NSString>("address", self) }
    var identifier: AlecrimCoreData.NullableAttribute<NSString> { return AlecrimCoreData.NullableAttribute<NSString>("identifier", self) }
    var name: AlecrimCoreData.NullableAttribute<NSString> { return AlecrimCoreData.NullableAttribute<NSString>("name", self) }

    var transactions: AlecrimCoreData.Attribute<NSSet> { return AlecrimCoreData.Attribute<NSSet>("transactions", self) }

}

// MARK: - DataContext extensions

extension DataContext {

    var tfrecipients: AlecrimCoreData.Table<TFRecipient> { return AlecrimCoreData.Table<TFRecipient>(dataContext: self) }

}

