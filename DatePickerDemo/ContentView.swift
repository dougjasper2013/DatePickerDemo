//
//  ContentView.swift
//  DatePickerDemo
//
//  Created by Douglas Jasper on 2025-02-26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate: Date = Date() // Holds the selected date
    @State private var selectedSeason: String = "Spring" // Default season selection

    let seasons = ["Spring", "Summer", "Fall", "Winter"] // List of seasons

    var body: some View {
        VStack(spacing: 20) {
            Text("Select a Date & Season")
                .font(.headline)

            // DatePicker to select a date
            DatePicker("Pick a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding()
                .labelsHidden()

            // Season Picker
            Picker("Favorite Season", selection: $selectedSeason) {
                ForEach(seasons, id: \.self) { season in
                    Text(season)
                }
            }
            .pickerStyle(.wheel)
            .padding()

            // Display selected date and season
            VStack(spacing: 10) {
                Label {
                    Text("\(selectedDate, formatter: dateFormatter)")
                        .font(.title2)
                        .bold()
                } icon: {
                    Image(systemName: "calendar")
                }

                Label {
                    Text("Favorite Season: \(selectedSeason)")
                        .font(.title2)
                        .bold()
                } icon: {
                    Image(systemName: "leaf")
                }
            }
            .padding()
        }
        .padding()
    }

    // Date Formatter
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

#Preview {
    ContentView()
}


