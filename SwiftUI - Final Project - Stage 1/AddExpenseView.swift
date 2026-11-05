//
//  AddExpenseView.swift
//  SwiftUI - Final Project - Stage 1
//
//  Created by NikoDanelia on 05/11/2026.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var amountString: String = ""
    @State private var selectedCategory: String = "საკვები"
    @State private var date: Date = Date()
    
    //  alert
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    // სიააააა
    let categories = ["საკვები", "ტრანსპორტი", "გართობა", "სხვა"]
    
    // Callback ახალი ხარჯის გადასაცემად ContentView-ში
    var onSave: (Expense) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("ხარჯის დეტალები")) {
                    // დასახელება
                    TextField("მაგ. სადილი", text: $title)
                    
                    // თანხა
                    HStack {
                        TextField("0.00", text: $amountString)
                            .keyboardType(.decimalPad)
                        Text("₾")
                            .foregroundColor(.gray)
                    }
                    
                    // კატეგორიაა
                    Picker("კატეგორია", selection: $selectedCategory) {
                        ForEach(categories, id: \.self){
                            Text($0)
                        }
                    }
                    
                    // თარიღი
                    DatePicker("თარიღი", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("ახალი ხარჯი")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // გაუქმების ღილაკი მარცხნივ
                ToolbarItem(placement: .cancellationAction) {
                    Button("გაუქმება") {
                        dismiss()
                    }
                }
                
                // შენახვის ღილაკი მარჯვნივ
                ToolbarItem(placement: .confirmationAction) {
                    Button("შენახვა") {
                        saveExpense()
                    }
                    .bold()
                }
            }
            //  შეცდომის Alert
            .alert("არასწორი მონაცემები", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // ლოგიკა
    private func saveExpense() {
        // 1. ცარიელი დასახელების შემოწმება
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedTitle.isEmpty {
            alertMessage = "გთხოვთ შეიყვანოთ ხარჯის დასახელება."
            showAlert = true
            return
        }
        
        // 2. ნული ან უარყოფითი თანხა არ უნდა შეინახოს
        guard let amount = Double(amountString.replacingOccurrences(of: ",", with: ".")), amount > 0 else {
            alertMessage = "გთხოვთ შეიყვანოთ 0-ზე მეტი სწორი თანხა."
            showAlert = true
            return
        }
        
        // 3. ახალი ხარჯის  შექმნა
        let newExpense = Expense(
            title: trimmedTitle,
            amount: amount,
            category: selectedCategory,
            date: date
        )
        
        // 4. შენახვა და ეკრანის დახურვა
        onSave(newExpense)
        dismiss()
    }
}

#Preview {
    AddExpenseView { _ in }
}
