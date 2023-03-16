//
//  ContentView.swift
//  pomodoro
//
//  Created by 渡辺恭平 on 2023/03/16.
//

import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 1500
    @State private var isWorking = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var workDuration = 1500
    @State private var showingSettings = false
    @State private var timerRunning = false
    @State private var timerCount = 0

    var body: some View {
        NavigationView {
            VStack {
                Text(isWorking ? "Work" : "Break")
                    .font(.largeTitle)
                    .padding()

                Text("\(timeRemaining / 60):\(timeRemaining % 60 < 10 ? "0" : "")\(timeRemaining % 60)")
                    .font(.system(size: 60))
                    .padding()

                HStack {
                    Button("Start") {
                        timerRunning = true
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }
                    .padding()

                    Button("Stop") {
                        timerRunning = false
                        timer.upstream.connect().cancel()
                    }
                    .padding()
                }

                HStack {
                    Text("Set: \(timerCount)")
                        .font(.headline)
                        .padding()

                    Button("Reset") {
                        resetTimer()
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Pomodoro Timer")
            .navigationBarItems(trailing: Button(action: {
                showingSettings = true
            }) {
                Image(systemName: "gear")
            })
            .sheet(isPresented: $showingSettings, onDismiss: {
                if isWorking {
                    timeRemaining = workDuration
                }
            }) {
                SettingsView(workDuration: $workDuration)
            }
            .onReceive(timer) { _ in
                if timerRunning && timeRemaining > 0 {
                    timeRemaining -= 1
                } else if timeRemaining == 0 {
                    timerRunning = false
                    isWorking.toggle()
                    resetTimer()
                    timer.upstream.connect().cancel()

                    if isWorking {
                        timerCount += 1
                    }
                    
                    if timerCount == 5 {
                        timerCount = 0
                        timer.upstream.connect().cancel()
                    }
                }
            }
        }
    }

    private func resetTimer() {
        if isWorking {
            timeRemaining = workDuration
        } else {
            timeRemaining = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
