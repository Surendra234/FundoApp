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
    
    var delegate: HomeControllerDeleget?
    
    // Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    // Handlers
    
    @objc func handleMenu() {
        delegate?.handleMenu(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        //navigationController?.navigationBar.backgroundColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "DashBoard"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "line3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
    }
}
