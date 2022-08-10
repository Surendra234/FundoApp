//
//  SettingSection.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 10/08/22.

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
    case Logout
    
    var controlSwtich: Bool { return false}
    
    var description: String {
        
        switch self {
        case .Username: return "surendra"
        case .Email: return "surendra@gail.com"
        case .Logout: return "Log out"
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


