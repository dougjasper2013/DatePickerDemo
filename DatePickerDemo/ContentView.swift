//
//  ContentView.swift
//  DatePickerDemo
//
//  Created by Douglas Jasper on 2025-02-26.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var selectedDate: Date = Date() // Holds the selected date & time
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

                // DatePicker to select both date and time
                DatePicker("Pick a date & time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.compact)
                    .padding()

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

                // Schedule Notification Button
                Button(action: {
                    scheduleNotification()
                }) {
                    Text("Schedule Notification")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // Display selected date, time, season, and age
                VStack(spacing: 10) {
                    Label {
                        Text("\(selectedDate, formatter: dateTimeFormatter)")
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
        .onAppear {
            requestNotificationPermission() // Ask for permission when app starts
        }
    }

    // Date & Time Formatter
    private var dateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }

    // Request Notification Permission
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("✅ Notification permission granted!")
            } else if let error = error {
                print("❌ Notification permission denied: \(error.localizedDescription)")
            }
        }
    }

    // Schedule Notification
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder!"

        // Convert date to local time zone
        let localDate = selectedDate
        let formattedDate = dateTimeFormatter.string(from: localDate)
        content.body = "Your event is scheduled for \(formattedDate)."
        
        content.sound = .default

        // Extract components in local time zone
        let calendar = Calendar.current
        let triggerDate = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: localDate)

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled for \(formattedDate) (Local Time)")
            }
        }
    }

}

#Preview {
    ContentView()
}
