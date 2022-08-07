//
//  MenuOption.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 28/07/22.
//

import UIKit


enum MenuOption: Int, CustomStringConvertible {
    
    case Home
    case Archive
    case Reminder
    case SignOut
    
    var description: String {
        switch self {
        case .Home: return "Home"
        case .Archive: return "Archive"
        case .Reminder: return "Reminder"
        case .SignOut: return "SignOut"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Home:
            return UIImage(systemName: "homekit")!.withRenderingMode(.alwaysOriginal)
        case .Archive:
            return UIImage(systemName: "square.and.arrow.down.fill")!.withRenderingMode(.alwaysOriginal)
        case .Reminder:
            return UIImage(systemName: "bell.badge")!.withRenderingMode(.alwaysOriginal)
        case .SignOut:
            return UIImage(named: "setting") ?? UIImage()
        }
    }
}
