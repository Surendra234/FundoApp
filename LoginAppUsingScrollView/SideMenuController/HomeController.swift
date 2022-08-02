//
//  HomeController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit
import SwiftUI

class HomeController: UIViewController {
    
    
    // Properties
    
    var myColletionView: UICollectionView!
    var delegate: HomeControllerDeleget?
    
    // Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 60, left: 20, bottom: 60, right: 20)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 100)

        myColletionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myColletionView.register(ListCell.self, forCellWithReuseIdentifier: "MyCell")
        myColletionView.backgroundColor = UIColor.white
        myColletionView.dataSource = self
        myColletionView.delegate = self
        self.view.addSubview(myColletionView)
        
        configureNavigationBar()
    }
    
    // Handlers
    
    @objc func handleMenu() {
        delegate?.handleMenu(forMenuOption: nil)
    }
    
    @objc func noteAdd() {
        let noteVC = NoteDetailVC()
        self.navigationController?.pushViewController(noteVC, animated: true)
    }
    
    
    // HomeDasboard Navigation Bar

    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
        navigationItem.title = "Keep Notes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "line3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "notes")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(noteAdd))
    }
}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ListCell
        mycell.backgroundColor = .green
        //mycell.layoutSubviews()
        //print("green color")
        return mycell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("user tapped on item \(indexPath.row)")
    }
}


//extension HomeController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionWidth = collectionView.bounds.width
//        return CGSize(width: collectionWidth/2-4, height: collectionWidth/2-4)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
//}
