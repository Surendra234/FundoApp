//
//  ViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 22/07/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        
    }
    
    
    @IBAction func loginButtonClick(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        validDetailsCheck()
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            if err != nil {
                //print("Login error")
                self.openAlert(title: "Alert", message: "Login Detail not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            } else {
                
                let homeVC = ContainerControllerVC()
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
    }
    
    
    // Login Button For Facebook
    
    @IBAction func FBLoginButtonClick(_ sender: UIButton) {
        let fbLoginVC = FBLoginVC()
        self.navigationController?.pushViewController(fbLoginVC, animated: true)
        
    }
    
    
    // Login button for Google
    
    @IBAction func googleLoginButtonClick(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if error != nil {
                //..
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credentialUser = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credentialUser) { result, error in
                
                if error != nil {
                    return
                } else {
                    let homeDashboard = ContainerControllerVC()
                    self.navigationController?.pushViewController(homeDashboard, animated: true)
                }
            }
            
        }
    }
    
    
    @IBAction func signUpButtonClick(_ sender: UIButton) {
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func PowerButton(_ sender: UIButton) {
        let homeController = ContainerControllerVC()
        self.navigationController?.pushViewController(homeController, animated: true)
    }
}
