//
//  HalfViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 15/08/22.
//

import UIKit

class SetReminderVC: UIViewController {

    var datePicker = UIDatePicker()
    var completion: ((Date, Bool) -> Void)?
    
    let setRemButton: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = UIColor(red: 50/255, green: 120/255, blue: 250/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.setTitle("done", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
        configureDatePicker()
    }
    
    
    @objc func handlerSetRemBtn() {
        
        let targetDate = datePicker.date
        completion!(targetDate, true)
        
        dismiss(animated: true)
    }
    
    func configureButton() {
        
        view.addSubview(setRemButton)
        setRemButton.translatesAutoresizingMaskIntoConstraints = false
        [
        setRemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        setRemButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        setRemButton.heightAnchor.constraint(equalToConstant: 40),
        setRemButton.widthAnchor.constraint(equalToConstant: 60)
        ].forEach { $0.isActive = true}
        
        setRemButton.addTarget(self, action: #selector(handlerSetRemBtn), for: .touchUpInside)
    }
    
    func configureDatePicker() {
        
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 300, width: 300, height: 50))
        datePicker.datePickerMode = .dateAndTime
        
        view.addSubview(datePicker)
    }
}
