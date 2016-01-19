//
//  TFCurrency.generated.swift
//
//  This code was generated by AlecrimCoreData code generator tool.
//
//  Changes to this file may cause incorrect behavior and will be lost if
//  the code is regenerated.
//

import Foundation
import CoreData

import AlecrimCoreData

// MARK: - TFCurrency properties

extension TFCurrency {

    @NSManaged public var code: String?
    @NSManaged public var identifier: String?
    @NSManaged public var name: String?

    @NSManaged public var transactions: Set<TFTransaction>

}

// MARK: - TFCurrency KVC compliant to-many accessors and helpers

extension TFCurrency {

    @NSManaged private func addTransactionsObject(object: TFTransaction)
    @NSManaged private func removeTransactionsObject(object: TFTransaction)
    @NSManaged public func addTransactions(transactions: Set<TFTransaction>)
    @NSManaged public func removeTransactions(transactions: Set<TFTransaction>)

    public func addTransaction(transaction: TFTransaction) { self.addTransactionsObject(transaction) }
    public func removeTransaction(transaction: TFTransaction) { self.removeTransactionsObject(transaction) }

}

// MARK: - TFCurrency query attributes

extension TFCurrency {

    public static let code = AlecrimCoreData.NullableAttribute<String>("code")
    public static let identifier = AlecrimCoreData.NullableAttribute<String>("identifier")
    public static let name = AlecrimCoreData.NullableAttribute<String>("name")

    public static let transactions = AlecrimCoreData.Attribute<Set<TFTransaction>>("transactions")

}

// MARK: - AttributeType extensions

extension AlecrimCoreData.AttributeType where Self.ValueType: TFCurrency {

    public var code: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("code", self) }
    public var identifier: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("identifier", self) }
    public var name: AlecrimCoreData.NullableAttribute<String> { return AlecrimCoreData.NullableAttribute<String>("name", self) }

    public var transactions: AlecrimCoreData.Attribute<Set<TFTransaction>> { return AlecrimCoreData.Attribute<Set<TFTransaction>>("transactions", self) }

}

// MARK: - DataContext extensions

extension DataContext {

    public var tfcurrencies: AlecrimCoreData.Table<TFCurrency> { return AlecrimCoreData.Table<TFCurrency>(dataContext: self) }

}

