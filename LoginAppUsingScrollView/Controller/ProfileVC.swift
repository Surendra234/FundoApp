//
//  ProfileViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 09/08/22.
//

import UIKit
import FirebaseStorage

private let reuseIdentifier = "SettingsCell"

class ProfileVC: UIViewController {
    
    var tableView: UITableView!
    
    let profileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleToFill
        imgView.backgroundColor = .white
        imgView.sizeToFit()
        imgView.layer.cornerRadius = 70
        imgView.image = UIImage(systemName: "person.fill")
        return imgView
    }()
    
    let photoLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.text = "Profile Picture"
        return lable
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpConstratin()
        configureTableView()

        UserService.getUserInfo { user in
   
            if user != nil {
                self.setProfileImage(imgUrl: (user!.photoUrl)!)
            }
        }
    }
    
    
    private func setProfileImage(imgUrl : String) {
        
        guard let url = URL(string: imgUrl) else { return}

        guard let data = try? Data(contentsOf: url) else { return}
 
        DispatchQueue.main.async {
            self.profileImage.image = UIImage(data: data)
        }
    }
    
    func setUpConstratin() {
        
        view.addSubview(profileImage)
        view.addSubview(photoLable)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        photoLable.translatesAutoresizingMaskIntoConstraints = false
        photoLable.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
        photoLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        photoLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        photoLable.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func configureTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: photoLable.bottomAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingSection(rawValue: section) else { return 0}
        
        switch section {
        case .UserInformation: return UserInformationOption.allCases.count
        case .Communication: return CommunicationOption.allCases.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingCell
        
        guard let section = SettingSection(rawValue: indexPath.section) else { return UITableViewCell()}
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch section {
            
        case .UserInformation:
            
            let userInfo = UserInformationOption(rawValue: indexPath.row)
            cell.sectionType = userInfo
            
        case .Communication:
            
            let communication = CommunicationOption(rawValue: indexPath.row)
            cell.sectionType = communication
        }
        
        return cell
    }
}
