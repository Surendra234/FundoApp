//
//  ArchiveNotesVC.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 06/08/22.
//

import UIKit

class ArchiveNotesVC: UIViewController {
    
    // Properties
    
    var notes: [Notes] = []
    var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        //self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.navigationItem.title = "Archive Notes"
        
        configureCollectionView()
    }
    
    
    // Mark: Colletion view
    
    func configureCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.register(ListCell.self, forCellWithReuseIdentifier: "ArchiveCell")
        myCollectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(myCollectionView)
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    
    func fetchArchiveNotes() {
        
        NoteService.shared.getArchiveNotes { note in
            self.notes = note
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchArchiveNotes()
    }
}


extension ArchiveNotesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchiveCell", for: indexPath) as! ListCell
        
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
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}


extension ArchiveNotesVC: UICollectionViewDelegateFlowLayout {
    
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
