//
//  Expense.swift
//  SwiftUI - Final Project - Stage 1
//
//  Created by NikoDanelia on 03/11/2026.
//

import Foundation

struct Expense: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let category: String
    let date: Date

}
 extension Expense{
     static let dummyData: [Expense] = [
             Expense(title: "სადილი", amount: 25.00, category: "საკვები", date: Date()),
             Expense(title: "ავტობუსი", amount: 2.00, category: "ტრანსპორტი", date: Date().addingTimeInterval(-86400)),
             Expense(title: "კინო", amount: 30.00, category: "გართობა", date: Date().addingTimeInterval(-172800))
         ]
     
}
