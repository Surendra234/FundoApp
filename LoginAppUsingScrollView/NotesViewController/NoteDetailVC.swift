//
//  NoteDetailVC.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 31/07/22.
//

import UIKit
import SwiftUI

class NoteDetailVC: UIViewController {
    
    // Properties
    
    let descriptionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        configureRightBarButton()
        setUpConstraint()
        configureTextView()
        
        titleTextField.becomeFirstResponder()
        
    }
    
    // Init
    
    let titleLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        lable.numberOfLines = 0
        lable.text = "Title"
        lable.textAlignment = .center
        return lable
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Enter title"
        return textField
    }()
    
    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        lable.numberOfLines = 0
        lable.text = "Description"
        lable.textAlignment = .center
        return lable
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    
    func setUpConstraint() {
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLable)
        view.addSubview(titleTextField)
        view.addSubview(deleteButton)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -30).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionLable.topAnchor.constraint(equalTo: titleTextField.topAnchor, constant: 60).isActive = true
        descriptionLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        descriptionLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        deleteButton.bottomAnchor.constraint(equalTo: descriptionLable.topAnchor, constant: 320).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func configureTextView()  {
        
        //descriptionTextView.text = "Enter your notes here"
        descriptionTextView.frame = CGRect(x: 30, y: 300, width: 200, height: 150)
        descriptionTextView.font = .systemFont(ofSize: 18)
        descriptionTextView.backgroundColor = .secondarySystemBackground
        
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        [
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLable.topAnchor, constant: 30),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLable.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionLable.trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 200),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 450)
        ].forEach{
            $0.isActive = true
        }
    }
    
    
    func configureRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNotes))
        
    }
    
    @objc func saveNotes() {
        
        navigationController?.popViewController(animated: true)
    }
}
