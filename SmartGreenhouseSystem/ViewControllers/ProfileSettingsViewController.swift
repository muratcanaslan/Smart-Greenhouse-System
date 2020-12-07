//
//  ProfileSettingsViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 22.11.2020.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var versionView: UIView!
    
    
    
    @IBOutlet weak var logoutButton: UIButton! {
        didSet{
            logoutButton.layer.cornerRadius = 20
            logoutButton.layer.borderWidth = 2
            logoutButton.layer.borderColor = CGColor(red: 0, green: 43, blue: 17, alpha: 0.2)
            logoutButton.backgroundColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
            logoutButton.tintColor = .white
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.2)
        
        logoutButton.setTitle("Logout", for: .normal)
        
        
        profileView.layer.borderWidth = 4
        profileView.layer.cornerRadius = 10
        profileView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
        versionView.layer.borderWidth = 4
        versionView.layer.cornerRadius = 10
        versionView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
        
        
        
        
        
        
        
        

    }
    
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        Device.sharedInstance.dropDevice()
        self.tabBarController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
}
