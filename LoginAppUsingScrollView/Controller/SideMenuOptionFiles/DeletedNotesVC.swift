//
//  DeletedNotesVC.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 15/08/22.
//

import UIKit

class DeletedNotesVC: UIViewController {

    // Properties
    
    var notes: [Notes] = []
    var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        //self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.navigationItem.title = "Deleted Notes"
        
        configureCollectionView()
    }
    
    
    // Mark: Colletion view
    
    func configureCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.register(ListCell.self, forCellWithReuseIdentifier: "DeleteCell")
        myCollectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(myCollectionView)
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    
    func fetchDeletednotes() {
        
        NoteService.shared.getDeleteNotes { note in
            self.notes = note
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDeletednotes()
    }
}


extension DeletedNotesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeleteCell", for: indexPath) as! ListCell
        
        cell.layer.cornerRadius = 30
        cell.layer.borderWidth = 1
        
        cell.titleLabel.text = notes[indexPath.row].title
        cell.descriptionLable.text = notes[indexPath.row].desc
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        let editVC = NoteDetailVC()
        let selectedNote: Notes!
        selectedNote = notes[indexPath.row]
        editVC.selectedNote = selectedNote
        
        editVC.isDelete = true
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}


extension DeletedNotesVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 40, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width - 15
        return CGSize(width: width, height: width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

