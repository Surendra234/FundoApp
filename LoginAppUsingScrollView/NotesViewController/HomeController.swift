//
//  HomeController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth

class HomeController: UIViewController {
    
    
    // Properties
    
    var myColletionView: UICollectionView!
    var delegate: HomeControllerDeleget?
    var searchBar: UISearchBar?
    
    
    // Marks: notesCollection
    
    var notes: [Notes] = []
    
    
    // Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
        configureCollectionView()
        configureNavigationBar()
        configureButton()
    }
    
    
    let addButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 35
        button.addTarget((Any).self, action: #selector(addNotes), for: .touchUpInside)
        return button
    }()
    
    
    
    func configureButton() {
        
        view.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    
    // Handlers
    
    @objc func handleMenu() {
        delegate?.handleMenu(forMenuOption: nil)
    }
    
    
    @objc func addNotes() {
        
        let noteVC = NoteDetailVC()
        noteVC.completion = {
            self.notes.append($0)
            self.myColletionView.reloadData()
        }
        self.navigationController?.pushViewController(noteVC, animated: true)
    }
    
    @objc func toggleButton() {
        // swithing between list and grid
    }
//
//    @objc func handleSearchBar() {
//
//        navigationItem.titleView = searchBar
//        searchBar?.showsCancelButton = true
//        navigationItem.rightBarButtonItem = nil
//    }
    
    
    func fetchNote() {
        
        NoteService.shared.fetchNotes { notes in
            self.notes = notes
            
            DispatchQueue.main.async {
                self.myColletionView.reloadData()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNote()
    }
    
    
    // HomeDasboard Navigation Bar
    
    func configureNavigationBar() {
        
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        navigationItem.title = "Keep Notes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "line3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.1x2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: (Any).self, action: #selector(toggleButton))

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
        
        
    }
    
    
    // Mark : Collection View
    
    func configureCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 40, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 20
        let wibth = (view.frame.size.width/2) - 15
        
        layout.itemSize = CGSize(width: wibth, height: wibth)
        
        myColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myColletionView.register(ListCell.self, forCellWithReuseIdentifier: "MyCell")
        myColletionView.backgroundColor = UIColor.white
        
        myColletionView.dataSource = self
        myColletionView.delegate = self
        
        self.view.addSubview(myColletionView)
    }
}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ListCell
        mycell.backgroundColor = .secondarySystemBackground
        
        mycell.titleLabel.text = notes[indexPath.row].title
        mycell.descriptionLable.text = notes[indexPath.row].desc
        mycell.layer.cornerRadius = 30
        mycell.layer.borderWidth = 2
        mycell.layer.borderColor = .init(red: 50/255, green: 120/255, blue: 250/255, alpha: 1)
        return mycell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("user tapped on item \(indexPath.row)")
        
        let editVC = NoteDetailVC()
        
        let selectedNote: Notes!
        selectedNote = notes[indexPath.row]
        editVC.selectedNote = selectedNote
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}


/*
 extension HomeController: UICollectionViewDelegateFlowLayout {
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 let collectionWidth = collectionView.bounds.width
 return CGSize(width: collectionWidth/2-4, height: collectionWidth/2-4)
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
 return 4
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
 return 4
 }
 }
 */
