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
    @State private var age: Double = 25 // Default age selection
    @State private var isYellowBackground: Bool = false // Controls background color

    let seasons = ["Spring", "Summer", "Fall", "Winter"] // List of seasons

    var body: some View {
        ZStack {
            // Background color changes based on toggle state
            (isYellowBackground ? Color.yellow : Color.white)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Select Your Info")
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

                // Age Slider
                VStack {
                    Text("Select Age: \(Int(age))")
                        .font(.title2)
                        .bold()
                    Slider(value: $age, in: 0...100, step: 1)
                        .padding()
                }

                // Toggle for background color
                Toggle("Yellow Background", isOn: $isYellowBackground)
                    .padding()
                    .font(.title2)

                // Display selected date, season, and age
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

                    Label {
                        Text("Age: \(Int(age)) years")
                            .font(.title2)
                            .bold()
                    } icon: {
                        Image(systemName: "person.fill")
                    }
                }
                .padding()
            }
            .padding()
        }
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
