//
//  ContentView.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 02/08/22.
//

import UIKit
import SwiftUI
import Firebase

struct ContentView: View {
    
    
    var body: some View {
        Text("Hello, World!")
    }
}

class GetNotes: ObservableObject {
    
    @Published var data = [Note]()
    @Published var noData = false
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("notes").addSnapshotListener { (snap, error) in
            
            if error != nil {
                
                print((error?.localizedDescription)!)
                self.noData = true
                return
            }
            
            if snap!.documentChanges.isEmpty {
                
                self.noData = true
                return
            }
            
            for i in snap!.documentChanges {
                
                if i.type == .added {
                    
                    let id = i.document.documentID
                    
                    let notes = i.document.get("notes") as! String
                    
                    let date = i.document.get("date") as! Timestamp
                    
                    let format = DateFormatter()
                    
                    format.dateFormat = "dd-MM-YY hh:mm a"
                    
                    let dateString = format.string(from: date.dateValue())
                    
                    self.data.append(Note(id: id, note: notes, date: dateString))
                }
                
                if i.type == .modified {
                    
                    // when data is changed
                }
                
                if i.type == .removed {
                    
                    // when data is removed
                }
            }
        }
    }
}

struct Note: Identifiable {
    
    var id: String
    var note: String
    var date: String
}


func saveData(txt: String) {
    
    let db = Firestore.firestore()
    
    db.collection("notes").document().setData(["notes": txt, "date": Date()]) { error in
        
        if error != nil {
            print((error?.localizedDescription)!)
            return
        }
    }

}
