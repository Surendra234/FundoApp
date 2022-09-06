//
//  SettingSection.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 10/08/22.

import Foundation

protocol SectionType: CustomStringConvertible {
    var controlSwtich: Bool { get }
}

enum SettingSection: Int, CaseIterable, CustomStringConvertible {

    case UserInformation
    case Communication
    
    var description: String {
        
        switch self {
        case .UserInformation: return "User Information"
        case .Communication: return "Communication"
        }
    }
}


enum UserInformationOption: Int, CaseIterable, SectionType {
    
    case Username
    case Email
    
    var controlSwtich: Bool { return false}

    var description: String {
        
        switch self {
        case .Username: return UserService.shared.getUsername()
        case .Email: return UserService.shared.getEmail()
        }
    }
}


enum CommunicationOption: Int, CaseIterable, SectionType {
    
    case Notification
    case Email
    case ReportCrashes
    
    var controlSwtich: Bool {
        
        switch self {
        case .Notification: return true
        case .Email: return true
        case .ReportCrashes: return true
        }
    }
    
    var description: String {
        
        switch self {
        case .Notification: return "Notification"
        case .Email: return "Email"
        case .ReportCrashes: return "Report Crashes"
        }
    }
}


