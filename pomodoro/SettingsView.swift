//
//  SettingsView.swift
//  pomodoro
//
//  Created by 渡辺恭平 on 2023/03/16.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var workDuration: Int

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Work Duration")) {
                    Picker("Work Duration", selection: $workDuration) {
                        Text("1 minutes").tag(5)
                        Text("10 minutes").tag(600)
                        Text("15 minutes").tag(900)
                        Text("20 minutes").tag(1200)
                        Text("25 minutes").tag(1500)
                    }
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(workDuration: .constant(1500))
    }
}

