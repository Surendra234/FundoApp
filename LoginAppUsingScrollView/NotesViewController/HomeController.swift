//
//  HomeController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit

class HomeController: UIViewController {
    
    // Properties
    
    var myColletionView: UICollectionView!
    var delegate: HomeControllerDeleget?
    
    let searchController = UISearchController()
    var isSearching = false
    
    var profileButton: UIBarButtonItem!
    var toggleButton: UIBarButtonItem!
    var isList = false
    
    
    // Marks: notesCollection
    
    private var notes: [Notes] = []
    private var searchNotes = [Notes]()
    
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
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
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
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
    
    @objc func isToggleButton() {
        
        if isList {
            
            toggleButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.1x2"), style: .plain, target: self, action: #selector(isToggleButton))
            isList = false
        }
        else {
            
            toggleButton = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(isToggleButton))
            isList = true
        }
        navigationItem.rightBarButtonItems = [profileButton, toggleButton]
        self.myColletionView.reloadData()
    }
    
    
    @objc func profileButtonClick() {
        // todo
        print("Tapped on profile button")
        
        let profileView = ProfileVC()
        self.navigationController?.pushViewController(profileView, animated: true)
    }
    
    
    func fetchNote() {
        
        NoteService.shared.fetchNotes { notes in

            self.notes = notes.reversed()
            DispatchQueue.main.async { self.myColletionView.reloadData() }
        }
    }
    
    // Mark : View will appear
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNote()
    }
    
    
    // Mark: HomeDasboard Navigation Bar
    
    func configureNavigationBar() {
        
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.navigationItem.title = "Keep Notes"
        self.navigationController?.hidesBarsOnSwipe = true
        
        // Navigavtion Bar items
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "line3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        
        profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(profileButtonClick))
        
        toggleButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.1x2"), style: .plain, target: self, action: #selector(isToggleButton))
        
        navigationItem.rightBarButtonItems = [profileButton, toggleButton]
        
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search your notes"
        searchController.searchBar.delegate = self
    }
    
    
    // Mark : Collection View
    
    func configureCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        myColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myColletionView.register(ListCell.self, forCellWithReuseIdentifier: "MyCell")
        myColletionView.backgroundColor = UIColor.white
        
        self.view.addSubview(myColletionView)
        
        myColletionView.dataSource = self
        myColletionView.delegate = self
        
        activityIndicator = LoadMoreActivityIndicator(scrollView: myColletionView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    }
}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isSearching ? searchNotes.count : notes.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mycell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ListCell
        mycell.backgroundColor = .secondarySystemBackground
        
        mycell.titleLabel.text = isSearching ? searchNotes[indexPath.row].title : notes[indexPath.row].title
        mycell.descriptionLable.text = isSearching ? searchNotes[indexPath.row].desc : notes[indexPath.row].desc
        
        mycell.layer.cornerRadius = 30
        //mycell.layer.borderWidth = 2
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
    
    
    // Mark : ScrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        activityIndicator.start {
            DispatchQueue.global(qos: .utility).async {
                for i in 0..<3 {
                    print("!!!!!!!!! \(i)")
                    sleep(1)
                }
                
                NoteService.shared.fetchMoreData(completion: { newNotes in
                    
                    self.notes.append(contentsOf: newNotes)
                    self.myColletionView.reloadData()
                })
                
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stop()
                }
            }
        }
    }
}


extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 40, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let collectionWidth = collectionView.bounds.width
        let listWidth = view.frame.size.width - 15
        let GridWibth = (view.frame.size.width/2) - 15
        
        if isList {
            return CGSize(width: listWidth, height: listWidth/2)
        } else {
            return CGSize(width: GridWibth, height: GridWibth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}



extension HomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchNotes = notes.filter {
            ($0.title?.lowercased().prefix(searchText.count))! == searchText.lowercased() ||
            ($0.desc?.lowercased().prefix(searchText.count))! == searchText.lowercased()
        }
        
        isSearching = true
        myColletionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        myColletionView.reloadData()
    }
}
