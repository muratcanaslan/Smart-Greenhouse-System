//
//  ViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 21.11.2020.
//

import UIKit
import Particle_SDK

class ViewController: UIViewController {
    

    @IBOutlet weak var loginButton: UIButton! {
        didSet{
            loginButton.layer.cornerRadius = 10
            loginButton.layer.borderWidth = 2
            loginButton.layer.borderColor = CGColor(red: 0, green: 43, blue: 17, alpha: 0.2)
            
        }
    }
    @IBOutlet weak var smartGreenhouseLabel: UILabel!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Root View Controller Arkaplan değişimi...
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "loginscreen")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
        backgroundImage.alpha = 0.7
        self.view.insertSubview(backgroundImage, at: 0)
        //Emailtext & Passwordtext attributes...
        emailtextField.font =  UIFont(name: "HelveticaNeue-Bold", size: 16)
        passwordTextField.font =  UIFont(name: "HelveticaNeue-Bold", size: 16)
        emailtextField.backgroundColor = .white //UIColor(red: 0.0, green: 0.17 , blue: 0.07, alpha: 0.20)
        passwordTextField.backgroundColor = .white //UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        emailtextField.attributedPlaceholder = NSAttributedString(string: "enter your particle e-mail.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "enter your particle password.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        
        }
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        //Login oluna yapılacak işlemler
        guard let username = emailtextField.text else {
            print("Username error")
            
            
            return
        }
        guard let password = passwordTextField.text else {
            print("Password error")
            
            
            
            return
        }
        
        
        
        ParticleCloud.sharedInstance().login(withUser: username, password: password) {
            error in
            
            if let error = error {
                print("Wrong credentials or no internet connectivity, please try again")
                print("Error: \(error.localizedDescription)")
                return
            }
            print("Logged into cloud..")
            
            ParticleCloud.sharedInstance().getDevices { (devices, error) in
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    return
                }
                if let device = devices?.first {
                    Device.sharedInstance.setDevice(device: device)
                    self.performSegue(withIdentifier: "toTabBarVcSegue", sender: nil)

                    
                }else{
                    print("No devices found on this account")
                }
            }
        }
        
        
    }
}




