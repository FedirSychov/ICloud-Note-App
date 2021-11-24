//
//  Note.swift
//  ICloud App
//
//  Created by Fedor Sychev on 20.11.2021.
//

import Foundation
import SwiftUI

struct Note: Identifiable, Encodable, Decodable {
    var id = UUID()
    var isDone: Bool
    var name: String
    var content: String
}

class AllNotes: ObservableObject {
    static var notes: [Note] = [
        Note(isDone: true, name: "note_1", content: "Here must be a big content"),
        Note(isDone: false, name: "note_2", content: "Here is a biiiiig content"),
        Note(isDone: false, name: "note_3", content: "Here is a biiiiig content"),
    ]
    
    static var tempNotes: [Note] = []
}
