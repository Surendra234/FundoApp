//
//  ViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 22/07/22.
//

import UIKit
import FirebaseAuth

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
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
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
    
    @IBAction func FBLoginButtonClick(_ sender: UIButton) {
        let FbLoginVC = FBLoginVC()
        self.navigationController?.pushViewController(FbLoginVC, animated: true)
    }
    
    @IBAction func signUpButtonClick(_ sender: UIButton) {
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
}

