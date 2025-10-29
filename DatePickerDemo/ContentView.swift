//
//  ContentView.swift
//  DatePickerDemo
//
//  Created by Douglas Jasper on 2025-10-29.
//

import SwiftUI

struct ContentView: View {
    // DatePicker state
    @State private var selectedDate = Date()
    
    // Picker state
    @State private var selectedSeason = "Spring"
    private let seasons = ["Spring", "Summer", "Autumn", "Winter"]
    
    // Date formatter
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // --- Date Picker ---
            Text("Select a Date")
                .font(.title)
                .bold()
            
            DatePicker("Pick a date:", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.graphical)
                .padding()
            
            Text("Selected Date: \(formattedDate)")
                .font(.headline)
                .foregroundColor(.blue)
            
            Divider()
            
            // --- Season Picker ---
            Text("Select Your Favorite Season")
                .font(.title2)
                .bold()
            
            Picker("Favorite Season", selection: $selectedSeason) {
                ForEach(seasons, id: \.self) { season in
                    Text(season)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150) // <-- Make the picker taller
            .clipped()
            
            Text("Your Favorite Season: \(selectedSeason)")
                .font(.headline)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
