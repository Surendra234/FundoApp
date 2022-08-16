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
    case Deleted
    case SignOut
    
    var description: String {
        switch self {
        case .Home: return "Home"
        case .Archive: return "Archive"
        case .Deleted: return "Deleted"
        case .SignOut: return "SignOut"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Home:
            return UIImage(systemName: "homekit")!.withRenderingMode(.alwaysOriginal)
        case .Archive:
            return UIImage(systemName: "square.and.arrow.down.fill")!.withRenderingMode(.alwaysOriginal)
        case .Deleted:
            return UIImage(systemName: "trash.fill")!.withRenderingMode(.alwaysTemplate)
        case .SignOut:
            return UIImage(named: "setting") ?? UIImage()
        }
    }
}
