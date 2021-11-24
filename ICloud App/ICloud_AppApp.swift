//
//  ICloud_AppApp.swift
//  ICloud App
//
//  Created by Fedor Sychev on 20.11.2021.
//

import SwiftUI

@main
struct ICloud_AppApp: App {
    @State var newWindow: Bool = false
    var body: some Scene {
        WindowGroup {
            if(!newWindow) {
                LoadingScreen()
                    .onAppear {
                        CloudHelper.GetNotesFromCloud()
                        print("TEST 1: " + String(AllNotes.tempNotes.count))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            print(String(AllNotes.tempNotes.count) + " returns")
                            newWindow = true
                        }
                    }
            } else {
                TabBar(Notes: AllNotes.tempNotes)
            }
        }
    }
}
