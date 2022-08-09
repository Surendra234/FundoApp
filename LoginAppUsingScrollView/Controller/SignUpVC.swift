//
//  SignUpVC.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 22/07/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseStorage

class SignUpVC: UIViewController {
    
    @IBOutlet var signUpScrollView: UIScrollView!
    
    var delegate: UserProfileImageDelegate?
    
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var textUsername: UITextField!
    @IBOutlet var textEmail: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var textConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
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
                
                if username == "" { print("Please enter username")}
                
                else if !email.isValidEmail() {
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("email is not valid")
                }
                
                else if !password.isValidPassword() { print("Password is not valid")}
                
                else {
                    if confirmPassword == "" { print("Please confirm password")}
                    
                    else {
                        if password == confirmPassword {
                            
                            // Mark: SignUp Succesfully
                            //print("Navigation code")
                            self.uplodeImage(username: username, email: email, password: password)}
                        
                        else { print("Password does not match")}
                    }
                }
            }
            else { print("Please check detail")}
        }
        else {
            openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])}
    }
    
    // transtion method sign to homedash board
    func transtionToHomeViewController() {
        
        let homeVC = ContainerControllerVC()
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
    
    // Mark: Uplode profile image
    
    private func uplodeImage(username: String, email: String, password: String) {
        
        guard let profileImg = imageProfile.image else { return }
        
        ImageUploder.uploadImage(image: profileImg) { imageURL in
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil { print("Got an error1")}
                
                else {
                    
                    let db = Firestore.firestore()
                    let doc = db.collection("users").document((result?.user.uid)!)
   
                    doc.setData(["user": username, "email" : email, "uid": result?.user.uid ?? (Any).self, "url": imageURL]) { (error) in
                        
                        if error != nil { print("got a error2")}
                    }
                    // trantion to HomeDashboard
                    self.transtionToHomeViewController()
                    
                    let url = URL(string: imageURL)
 
                    let data = try? Data(contentsOf: url!)
                    
                    //let profileImgVC = ProfileVC()
            
                    DispatchQueue.main.async {
                        self.delegate?.userProfile(image: UIImage(data: data!)!)
                        print("delegate call")
                    }
                }
            }
        }
    }
}


//    private func retrivewData(imageURl: String) -> String{
//
//        var imgData: String
//
//        let db = Firestore.firestore()
//        db.collection("users").document().getDocument { snapshot, error in
//
//            if error == nil && snapshot != nil {
//
//                for doc in snapshot!.documentID {
//
//                    //imageURl = (doc["url"] as? String)!
//
//                    // get a ref to storage
//                    let storageRef = Storage.storage().reference()
//
//                    // specify the path
//                    let filePath = storageRef.child(imageURl)
//
//                    filePath.getData(maxSize: 64) { Data, error in
//
//                        if let image = UIImage(data: Data!) {
//
//                            DispatchQueue.main.async {
//                              imgData   = image
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        return imgData
//    }


// Mark: ImagePicker

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
