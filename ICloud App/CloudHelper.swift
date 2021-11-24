//
//  CloudHelper.swift
//  ICloud App
//
//  Created by Fedor Sychev on 20.11.2021.
//

import Foundation
import CloudKit

class CloudHelper {
    
    ///
    /// Keys for saving into iCloud
    ///
    struct CloudKeys {
        static let recordType = "MainSettings"
        static let recordKey = "MyNotes"
        static let NotesRecordID = CKRecord.ID(recordName: "CurrentNotes")
    }
    
    static let DataBase = CKContainer(identifier: "iCloud.petmasterstorage").privateCloudDatabase
    
    static func SaveToCloud(notes: [Note]) {
        let newNotes = CKRecord(recordType: CloudKeys.recordType, recordID: CloudKeys.NotesRecordID)
        if let data = try? PropertyListEncoder().encode(notes) {
            newNotes.setValue(data, forKey: CloudKeys.recordKey)
        }
        
        DataBase.save(newNotes) { record, error in
            print("record id: \(String(describing: record?.recordID))")
            print(error ?? "No errors")
            guard record != nil else { return }
        }
    }
    
    static func GetNotesFromCloud() {
        let refs = CKRecord.Reference(recordID: CloudKeys.NotesRecordID, action: .none)
        let pred1 = NSPredicate(format: "recordID = %@", refs)
        
        let query = CKQuery(recordType: CloudKeys.recordType, predicate: pred1)
        DataBase.perform(query, inZoneWith: nil) { records, error in
            guard let record = records else { return }
            if record.count > 0 {
                let temp: [Note] = try! PropertyListDecoder().decode([Note].self, from: record[0].value(forKey: CloudKeys.recordKey) as! Data)
                AllNotes.tempNotes = temp
            }
        }
    }
    
    static func removeFromCloud(recordID: CKRecord.ID) {
        DataBase.delete(withRecordID: recordID) { record, error in
            if let err = error {
                print(err)
                return
            }
            guard record != nil else {
                return
            }
        }
    }
    
    ///
    /// First deleting information from iCloud and then adding
    /// 
    static func updateCloud(notes: [Note]) {
        CloudHelper.removeFromCloud(recordID: CloudKeys.NotesRecordID)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            CloudHelper.SaveToCloud(notes: notes)
        }
    }
}
