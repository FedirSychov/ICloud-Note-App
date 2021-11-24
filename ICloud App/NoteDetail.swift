//
//  NoteDetail.swift
//  ICloud App
//
//  Created by Fedor Sychev on 20.11.2021.
//

import SwiftUI

struct NoteDetail: View {
    @Binding var currentNote: Note
    @Binding var allNotes: [Note]
    @State var newName: String = ""
    @State var newContent: String = ""
    var heightText: CGFloat = screen.height
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            VStack {
                TextField(currentNote.name, text: $newName)
                    .foregroundColor(.green)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black)
                    .onTapGesture {
                        currentNote.content = newContent
                    }
                ScrollView {
                    VStack(alignment: .leading) {
                        MultilineTextField(currentNote.content, text: $newContent)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.green)
                            //.font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color.black)
                            .frame(width: screen.width, height: screen.height*0.5, alignment: .topLeading)
                            .onTapGesture {
                                currentNote.name = newName
                        }
                        Spacer()
                    }
                    .frame(width: screen.width, height: heightText)
                }
            }
        }
        .toolbar {
            Text("Save")
                .foregroundColor(.blue)
                .onTapGesture {
                    currentNote.name = newName
                    currentNote.content = newContent
                    CloudHelper.updateCloud(notes: allNotes)
                    presentationMode.wrappedValue.dismiss()
                }
        }
        .onAppear {
            newContent = currentNote.content
            newName = currentNote.name
        }
    }
}

struct NoteDetail_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetail(currentNote: .constant(Note(isDone: true, name: "1", content: "1")), allNotes: .constant([Note(isDone: true, name: "1", content: "1")]))
    }
}
