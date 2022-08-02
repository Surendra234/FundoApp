//
//  MenuOption.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 28/07/22.
//

import UIKit


enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Notes
    case Notification
    case Setting
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Notes: return "notes"
        case .Notification: return "Notification"
        case .Setting: return "SignOut"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile:
            return UIImage(named: "person") ?? UIImage()
        case .Notes:
            return UIImage(named: "notes") ?? UIImage()
        case .Notification:
            return UIImage(named: "notification") ?? UIImage()
        case .Setting:
            return UIImage(named: "setting") ?? UIImage()
        }
    }
}
