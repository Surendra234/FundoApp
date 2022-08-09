//
//  Protocols.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit


protocol HomeControllerDeleget {
    
    func handleMenu(forMenuOption menuOption: MenuOption?)
}


protocol UserProfileImageDelegate {
    
    func userProfile(image: UIImage)
}
