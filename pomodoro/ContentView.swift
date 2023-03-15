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

    var body: some View {
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
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isWorking.toggle()
                resetTimer()
                timer.upstream.connect().cancel()
            }
        }
    }

    private func resetTimer() {
        if isWorking {
            timeRemaining = 1500 // 25 minutes in seconds
        } else {
            timeRemaining = 300 // 5 minutes in seconds
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

