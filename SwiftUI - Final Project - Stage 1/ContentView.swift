//
//  ContentView.swift
//  SwiftUI - Final Project - Stage 1
//
//  Created by NikoDanelia on 03/11/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses: [Expense] = Expense.dummyData
    @State private var isShowingAddView: Bool = false
    // ხარჯების ჯამის გამოთვლა
    private var totalAmount: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 2) {
                HStack{
                    Text("ჩემი ბიუჯეტი")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    Spacer()
                    
                    Button {
                        isShowingAddView = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                             
                .padding(.horizontal)
                .padding(.vertical, 5)
                
                // 2. სია
                if expenses.isEmpty {
                    ContentUnavailableView(
                        "ხარჯები არ არის",
                        systemImage: "tray",
                        description: Text("თქვენ ჯერ არ დაგიმატებიათ არცერთი ხარჯი.")
                    )
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        
                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("ამ თვის ხარჯი")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Text(String(format: "ჯამი: %.2f ₾", totalAmount))
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color.blue) // ბარათის ლურჯი ფონი
                        
                        
                        Section(header: Text("ხარჯები")) {
                            VStack(spacing: 15) {
                                ForEach(expenses) { expense in
                                    HStack {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(expense.title)
                                                .font(.headline)
                                            
                                            Text("\(expense.category) · \(expense.date.formatted(date: .numeric, time: .omitted))")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Text(String(format: "%.2f ₾", expense.amount))
                                            .font(.headline)
                                            .bold()
                                    }
                                    
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 3.0)
                                )
                        )
                        
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    
                    
                }
            }
            .sheet(isPresented: $isShowingAddView){
                AddExpenseView{ expenses.append($0)
                    
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
