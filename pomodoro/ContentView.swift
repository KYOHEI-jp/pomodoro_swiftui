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
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }
                    .padding()

                    Button("Stop") {
                        timer.upstream.connect().cancel()
                    }
                    .padding()
                }

                Button("Reset") {
                    resetTimer()
                }
                .padding()
            }
            .navigationBarTitle("Pomodoro Timer")
            .navigationBarItems(trailing: Button(action: {
                showingSettings = true
            }) {
                Image(systemName: "gear")
            })
            .sheet(isPresented: $showingSettings) {
                SettingsView(workDuration: $workDuration)
            }
        }
    }

    private func resetTimer() {
        if isWorking {
            timeRemaining = workDuration
        } else {
            timeRemaining = 300
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
