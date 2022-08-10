//
//  NoteServiceViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 03/08/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class NoteService {
    
    static let shared = NoteService()
    
    // Mark : Featch Notes
    
    //@escaping and @resultset
    
    func fetchNotes(completion: @escaping ([Notes]) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let db = Firestore.firestore()
        var notes: [Notes] = []
        
        db.collection("users").document(user.uid).collection("Notes").order(by: "createdAt").getDocuments { snapShot, error in
            
            if error != nil {
                
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            
            for doc in snapShot!.documents {
                
                guard let id = doc["id"] as? String else { return }
                guard let title = doc["title"] as? String else { return }
                guard let desc = doc["desc"] as? String else { return }
                
                let note = Notes(id: id, title: title, desc: desc)
                
                notes.insert(note, at: 0)
            }
            
            completion(notes)
        }
    }
    
    
    // Mark : Create Notes
    
    func createNote(title: String, describe: String, completion: @escaping (Error?) -> Void) {
        
        if let user = Auth.auth().currentUser {
            
            let db = Firestore.firestore()
            let doc = db.collection("users").document(user.uid).collection("Notes").document()
            
            doc.setData(["id": doc.documentID, "title": title, "desc": describe, "createdAt": Timestamp(date: Date())]) { err in
                
                completion(err)
            }
        }
    }
    
    
    // Mark : Delete Notes
    
    func deleteNote(id: String, completion: @escaping (Bool) -> Void) {
        
        if let user = Auth.auth().currentUser {
            
            let db = Firestore.firestore()
            
            db.collection("users").document(user.uid).collection("Notes").document(id).delete() { err in
                
                if err != nil {
                    print("error")
                    completion(false)
                }
                completion(true)
            }
        }
    }
    
    
    // Mark : Update Note
    
    func updateNotes(id: String, title: String, desc: String, completion: @escaping (Bool) -> Void) {
        
        if let user = Auth.auth().currentUser {
            
            let db = Firestore.firestore()
            
            db.collection("users").document(user.uid).collection("Notes").document(id).updateData(["title": title, "desc": desc]) { err in
                
                if err != nil {
                    print("error")
                    completion(false)
                }
                completion(true)
            }
        }
    }
}

