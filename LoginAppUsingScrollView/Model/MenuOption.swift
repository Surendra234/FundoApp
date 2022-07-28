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
    case Settings
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Notes: return "notes"
        case .Notification: return "Notification"
        case .Settings: return "Settings"
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
        case .Settings:
            return UIImage(named: "setting") ?? UIImage()
        }
    }
}
