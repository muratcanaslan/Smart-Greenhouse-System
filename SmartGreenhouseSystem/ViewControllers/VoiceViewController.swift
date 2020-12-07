//
//  VoiceViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 22.11.2020.
//

import UIKit



class VoiceViewController: UIViewController {
    
  
    @IBOutlet weak var tomatoCardView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Information"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        
        tomatoCardView.layer.borderWidth = 4
        tomatoCardView.layer.cornerRadius = 10
        tomatoCardView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)


    }
    
    

}
