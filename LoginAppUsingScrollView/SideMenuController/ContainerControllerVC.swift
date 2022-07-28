//
//  ContainerControllerViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit

class ContainerControllerVC: UIViewController {

    
    // Properties

    var menuController: UIViewController!
    
    // Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Handlers
    
    func configureHomeController() {
        
        let homeController = HomeController()
        homeController.delegate = self
        let controller = UINavigationController(rootViewController: homeController)
        
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func configureMenuController() {
        
        if menuController == nil {
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Did add menu acontroller")
        }
    }
    
    
    func showMenuController(shouldExpand: Bool) {
        
        if shouldExpand {
            // show menu
            //UIView.animate
        }
    }
}

extension ContainerControllerVC: HomeControllerDeleget {
    func handleMenu() {
        configureMenuController()
    }
}
