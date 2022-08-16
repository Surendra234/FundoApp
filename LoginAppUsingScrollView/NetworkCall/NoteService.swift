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
    
    var lastDocument: QueryDocumentSnapshot?
    
    // Mark : Featch Notes
    
    //@escaping and @resultset
    
    
    // Mark: parseJson method to set data
    
    private func parseJson(snapshot: QuerySnapshot?, error: Error?, completion: @escaping ([Notes]) -> Void) {
        
        if error != nil {
            
            print("\(String(describing: error?.localizedDescription))")
            return
        }
        
        self.lastDocument = snapshot?.documents.last
        var notes: [Notes] = []
        for doc in snapshot!.documents {
            
            guard let id = doc["id"] as? String else { return }
            guard let title = doc["title"] as? String else { return }
            guard let desc = doc["desc"] as? String else { return }
            
            let note = Notes(id: id, title: title, desc: desc)
            
            notes.insert(note, at: 0)
        }
        
        completion(notes)
    }
    
    
    // Mark: Fetching data
    
    func fetchNotes(completion: @escaping ([Notes]) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user.uid).collection("Notes").order(by: "createdAt", descending: true).whereField("archive", isEqualTo: false).whereField("delete", isEqualTo: false).limit(to: 10).getDocuments { snapShot, error in
            
            self.parseJson(snapshot: snapShot, error: error, completion: completion)
        }
    }
    
    
    // Mark : Fetching data after scrolling
    
    func fetchMoreData(completion: @escaping ([Notes]) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let db = Firestore.firestore()
        
        if lastDocument != nil {
            
            db.collection("users").document(user.uid).collection("Notes").order(by:"createdAt", descending: true).whereField("archive", isEqualTo: false).whereField("delete", isEqualTo: false).start(afterDocument: lastDocument!).limit(to: 10).getDocuments { snapshot, err in
                
                self.parseJson(snapshot: snapshot, error: err, completion: completion)
            }
        }
    }
    
    
    // Mark : Create Notes
    
    func createNote(title: String, describe: String, archive: Bool, delete: Bool, completion: @escaping (Error?) -> Void) {
        
        if let user = Auth.auth().currentUser {
            
            let db = Firestore.firestore()
            let doc = db.collection("users").document(user.uid).collection("Notes").document()
            
            doc.setData(["id": doc.documentID, "title": title, "desc": describe, "archive": archive, "delete": delete, "createdAt": Timestamp(date: Date())]) { err in
                
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
    
    func updateNotes(id: String, title: String, desc: String, archive: Bool, delete: Bool, completion: @escaping (Bool) -> Void) {
        
        if let user = Auth.auth().currentUser {
            
            let db = Firestore.firestore()
            
            db.collection("users").document(user.uid).collection("Notes").document(id).updateData(["title": title, "desc": desc, "archive": archive, "delete": delete]) { err in
                
                if err != nil {
                    print("error")
                    completion(false)
                }
                completion(true)
            }
        }
    }
    
    // Mark : Archive Note
    
   func getArchiveNotes(complition: @escaping ([Notes]) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user.uid).collection("Notes").order(by: "createdAt").whereField("archive", isEqualTo: true).limit(to: 10).getDocuments { snapshot, error in
        
            self.parseJsonGetNotes(snapshot: snapshot, error: error, completion: complition)
        }
    }
    
    
    // Mark : Get Delete Notes
    
    func getDeleteNotes(complition: @escaping ([Notes]) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user.uid).collection("Notes").order(by: "createdAt").whereField("delete", isEqualTo: true).limit(to: 10).getDocuments { snapshot, error in

            self.parseJsonGetNotes(snapshot: snapshot, error: error, completion: complition)
        }
    }
    
    
    // Mark : parseJson method to get data
    
    private func parseJsonGetNotes(snapshot: QuerySnapshot?, error: Error?, completion: @escaping ([Notes]) -> Void) {
        
        if error != nil {
            print("error\(String(describing: error?.localizedDescription))")
            return
        }
        
        var noteArr: [Notes] = []
        for doc in snapshot!.documents {
            
            guard let id = doc["id"] as? String else { return }
            guard let title = doc["title"] as? String else { return }
            guard let desc = doc["desc"] as? String else { return }
            guard let archive = doc["archive"] as? Bool else { return }
            guard let delete = doc["delete"] as? Bool else { return}
            
            let notes = Notes(id: id, title: title, desc: desc, archive: archive, delete: delete)
            noteArr.insert(notes, at: 0)
        }
        completion(noteArr)
    }
}
