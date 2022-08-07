//
//  FBLoginVC.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 28/07/22.
//

import UIKit
import FacebookLogin
import FirebaseAuth
import FirebaseFirestore

class FBLoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            print("One")
        } else {
            print("Two")
            //print(AccessToken.current)
            loginButton.permissions = ["public_profile", "email"]
            loginButton.delegate = self
        }
    }
}

extension FBLoginVC: LoginButtonDelegate {
    
   
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name"], tokenString: token, version: nil, httpMethod: .get)

        request.start { (connection, result, error) in
            print("\(String(describing: result))")

            guard let curentUser = AccessToken.current else { return }

            let credential = FacebookAuthProvider
                .credential(withAccessToken: curentUser.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                
                if error != nil {
                    //print(error?.localizedDescription)
                    return
                }
                else {
                    //print("Login")
                    let homeDashboardVC = ContainerControllerVC()
                    self.navigationController?.pushViewController(homeDashboardVC, animated: true)
                }
            }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}
