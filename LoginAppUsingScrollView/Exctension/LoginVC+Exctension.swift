//
//  ViewController+Exctension.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 22/07/22.
//

import Foundation
import UIKit

extension LoginVC {
    
    func validDetailsCheck() {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            if !email.isValidEmail() {
                openAlert(title: "Alert", message: "Email address not found", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                    
                }])
            }
            else if !password.isValidPassword() {
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                    
                }])
            } else {
                // Navigation Home Screen
                print("User Detail Match!")
            }
        }
        
        else {
            openAlert(title: "Alert", message: "Please add detail", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
                
            }])
        }
    }
}