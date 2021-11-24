//
//  tabBar.swift
//  ICloud App
//
//  Created by Fedor Sychev on 20.11.2021.
//

import SwiftUI

struct TabBar: View {
    @State var Notes: [Note]
    
    var body: some View {
        TabView {
            MainView().tabItem {
                Image(systemName: "doc")
                Text("Menu")
            }
            Notes_Table(notes: $Notes).tabItem {
                Image(systemName: "tray.circle.fill")
                Text("Notes")
            }
        }
        .onAppear {
            CloudHelper.GetNotesFromCloud()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                print(AllNotes.notes.count)
                for note in AllNotes.notes {
                    print(note.name)
                }
            }
        }
    }
}

struct tabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(Notes: [Note(isDone: false, name: "note_2", content: "Here is a biiiiig content")])
    }
}
