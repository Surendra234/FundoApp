//
//  SignUpVC.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 22/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SignUpVC: UIViewController {

    @IBOutlet var signUpScrollView: UIScrollView!
    
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var textUsername: UITextField!
    @IBOutlet var textEmail: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var textConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgTap(tapGestureRecognizer:)))
        imageProfile.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func imgTap(tapGestureRecognizer: UITapGestureRecognizer) {
        openGallery()
    }
    
    override func viewDidLayoutSubviews() {
        signUpScrollView.isScrollEnabled = true
        signUpScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
    }
    
    
    @IBAction func loginClickButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpButtonClick(_ sender: UIButton) {
        let systemImg = UIImage(systemName: "person")
        
        if imageProfile.image?.pngData() != systemImg?.pngData() {
            
            if let email = textEmail.text, let username = textUsername.text, let password = textPassword.text, let confirmPassword = textConfirmPassword.text {
                
                if username == "" {
                    print("Please enter username")
                }
                else if !email.isValidEmail() {
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("email is not valid")
                }
                else if !password.isValidPassword() {
                    print("Password is not valid")
                }else {
                    if confirmPassword == "" {
                        print("Please confirm password")
                    }
                    else {
                        if password == confirmPassword {
                            //print("Navigation code")
                            
                            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                                
                                if err != nil {
                                    print("Got an error1")
                                } else {
                                    
                                    let db = Firestore.firestore()
                                    db.collection("users").addDocument(data: ["username": username, "uid": result!.user.uid]) { (error) in
                                        
                                        if error != nil {
                                            print("got a error2")
                                        }
                                    }
                                    // trantion to HomeDashboard
                                    self.transtionToHomeViewController()
                                }
                            }
                            
                        }else {
                            print("Password does not match")
                        }
                    }
                }
            }
            else {
                print("Please check detail")
            }
        }
        else {
            openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
    }
    
    // transtion method sign to homedash board
    func transtionToHomeViewController() {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeViewController) as? HomeDashboardVC
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}

extension SignUpVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .savedPhotosAlbum
            present(imgPicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            imageProfile.image = img
        }
        dismiss(animated: true)
    }
}
