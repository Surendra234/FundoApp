//
//  MenuController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit

private let reuseIdentifire = "MenuOptionCell"

class MenuController: UIViewController {

    // Properties

    var tableView: UITableView!
    var delegate: HomeControllerDeleget?
    
    // Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }

    
    // Handler
    
    func configureTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifire)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath) as! MenuOptionCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.backgroundColor = .white
        cell.descriptionLable.text = menuOption?.description
        cell.iconImgView.image = menuOption?.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenu(forMenuOption: menuOption)
    }
}
