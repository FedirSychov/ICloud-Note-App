//
//  Notes-Table.swift
//  ICloud App
//
//  Created by Fedor Sychev on 20.11.2021.
//

import SwiftUI
import Combine

struct Notes_Table: View {
    @Binding var notes: [Note]
    
    func addUpdate() {
        notes.append(Note(isDone: true, name: "note_new", content: "Some content"))
    }
    
    var body: some View {
        VStack {
            NavigationView {
                    List {
                        ForEach($notes) { note in
                            NoteCell(note: note, allNotes: $notes)
                        }
                        .onDelete { index in
                            self.notes.remove(at: index.first!)
                        }
                        .onMove { (source: IndexSet, destination: Int) in
                            self.notes.move(fromOffsets: source, toOffset: destination)
                        }
                    }
                    .navigationBarTitle(Text("Notes"))
                    .navigationBarItems(leading: Button(action: addUpdate) {
                        Text("Add Note")
                    }, trailing: EditButton())
            }
            .navigationViewStyle(StackNavigationViewStyle())
            //Text(AllNotes.notes[0].name + "   " + self.notes[0].name)
        }
    }
}

struct Notes_Table_Previews: PreviewProvider {
    static var previews: some View {
        Notes_Table(notes: .constant([Note(isDone: false, name: "note_2", content: "Here is a biiiiig content")]))
    }
}

struct NoteCell: View {
    @Binding var note: Note
    @Binding var allNotes: [Note]
    
    var body: some View {
        NavigationLink(destination: NoteDetail(currentNote: $note, allNotes: $allNotes)){
            HStack {
                if note.isDone {
                    Image(systemName: "circle.inset.filled")
                        .onTapGesture {
                            note.isDone.toggle()
                        }
                } else {
                    Image(systemName: "circle")
                        .onTapGesture {
                            note.isDone.toggle()
                        }
                }
                Text(note.name)
            }
        }
    }
}
