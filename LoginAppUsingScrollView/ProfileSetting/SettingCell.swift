//
//  SettingCell.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 09/08/22.
//

import UIKit

class SettingCell: UITableViewCell {
    
    // Mark: Properties
    
    var sectionType: SectionType? {
        
        didSet {
            guard let sectionType = sectionType else { return}
            textLabel?.text = sectionType.description
            switchControl.isHidden = !sectionType.controlSwtich
        }
    }
    
    
    lazy var switchControl: UISwitch = {
      
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = UIColor(red: 55/250, green: 120/250, blue: 250/255, alpha: 1)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    // Mark: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark : Selector
    
    @objc func handleSwitchAction(sender: UISwitch) {
        
        if sender.isOn {
            print("turn on")
        }
        else {
            print("turn off")
        }
    }
}
