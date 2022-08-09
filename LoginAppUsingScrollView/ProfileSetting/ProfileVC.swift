//
//  ProfileViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 09/08/22.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

private let reuseIdentifier = "SettingsCell"

class ProfileVC: UIViewController {
    
    let signUpVc = SignUpVC()
    
    var tableView: UITableView!
    //var userInfoHeader: UserInfoHeader!
    
    let profileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleToFill
        imgView.sizeToFit()
        imgView.layer.cornerRadius = 70
        return imgView
    }()
    
    let photoLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.text = "Profile Picture"
        return lable
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationItem.backButtonTitle = "Profile Setting"
        
        setUpConstraint()
        
        configureTableView()
        
        signUpVc.delegate = self
        setProfileImage()
    }
    
    func setUpConstraint() {
        
        view.addSubview(profileImage)
        view.addSubview(photoLable)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        photoLable.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 10).isActive = true
        photoLable.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        photoLable.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor).isActive = true
        photoLable.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        
//        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
//
//        tableView.frame(forAlignmentRect: frame)
        //tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 30).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    private func setProfileImage() {
        
        let url = URL(string: "https://firebasestorage.googleapis.com:443/v0/b/loginappusingscrollview.appspot.com/o/profile_image%2F3DF688E1-6A46-4823-A527-DA0BCB781ED6?alt=media&token=9df1d2e4-0750-4682-8a0e-de197c7ee97d")
        
        let data = try? Data(contentsOf: url!)
        
        DispatchQueue.main.async {
            self.profileImage.image = UIImage(data: data!)
        }
    }
}


extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingCell
        cell.backgroundColor = .red
        return cell
    }
}


extension ProfileVC: UserProfileImageDelegate {
    
    func userProfile(image: UIImage) {
        print("extention for delegate")
        DispatchQueue.main.async {
            self.profileImage.image = image
        }
    }
}
