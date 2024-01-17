//
//  ContentView.swift
//  WeSplit
//
//  Created by Jay Park on 2024-01-09.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 9

    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages = [10, 15, 18, 20, 25, 0]
    
    var grandTotal : Double {
        let tipsSelection = Double(tipPercentage)
        return checkAmount + checkAmount * (tipsSelection + 1) / 100
    }
    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipsSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipsSelection
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body : some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value : $checkAmount, format : .currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection : $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentages", selection : $tipPercentage) {
                        ForEach(1..<100) {
                            Text($0, format: .percent)
                        }
                    }
                }
                
                Section("Total Check : ") {
                    Text(grandTotal, format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person"){
                    Text(totalPerPerson, format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black
)
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    
    }
}

#Preview {
    ContentView()
}
