//
//  HomeDashboardViewController.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit

class HomeDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var sideView: UIView!
    @IBOutlet var sideBar: UITableView!
    
    
    var arrData = ["Profile", "Notes", "SignOut"]
    var isSideViewOpen: Bool = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.label.text = arrData[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideView.isHidden = true
        sideBar.backgroundColor = UIColor.groupTableViewBackground
        isSideViewOpen = false
    }
    
    @IBAction func SideMenuButton(_ sender: UIButton) {
        
        sideBar.isHidden = false
        sideView.isHidden = false
        self.view.bringSubviewToFront(sideView)
        
        if !isSideViewOpen {
            isSideViewOpen = true
            sideView.frame = CGRect(x: 0, y: 88, width: 0, height: 775)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 775)
            
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            
            sideView.frame = CGRect(x: 0, y: 88, width: 250, height: 775)
            sideBar.frame = CGRect(x: 0, y: 0, width: 250, height: 775)
            
            UIView.commitAnimations()
        }
        else {
            sideBar.isHidden = true
            sideView.isHidden = true
            isSideViewOpen = false
            
            sideView.frame = CGRect(x: 0, y: 88, width: 250, height: 775)
            sideBar.frame = CGRect(x: 0, y: 0, width: 250, height: 775)
            
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            
            sideView.frame = CGRect(x: 0, y: 88, width: 0, height: 775)
            sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 775)
            
            UIView.commitAnimations()
        }
    }
}
