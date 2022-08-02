//
//  MenuOptionCell.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 28/07/22.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    
    // Properties
    
    let iconImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.backgroundColor = .white
        return imgView
    }()
    
    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.text = "Sample text"
        return lable
    }()
    
    // Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(iconImgView)
        
        iconImgView.translatesAutoresizingMaskIntoConstraints = false
        iconImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        iconImgView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImgView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(descriptionLable)
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLable.leftAnchor.constraint(equalTo: iconImgView.rightAnchor, constant: 12).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Handlers
    
}
