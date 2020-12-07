//
//  RoofControlViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 22.11.2020.
//

import UIKit

class RoofControlViewController: UIViewController {
    
    @IBOutlet weak var leftRoofButtonOutlet: UIButton! {
       didSet{
        
        leftRoofButtonOutlet.layer.cornerRadius = 10
        leftRoofButtonOutlet.layer.borderWidth = 2
        leftRoofButtonOutlet.layer.borderColor = CGColor(red: 0, green: 43, blue: 17, alpha: 0.2)
        leftRoofButtonOutlet.tintColor = .white
    }
}
    @IBOutlet weak var rightRoofButtonOutlet: UIButton! {
        didSet{
            rightRoofButtonOutlet.layer.cornerRadius = 10
            rightRoofButtonOutlet.layer.borderWidth = 2
            rightRoofButtonOutlet.layer.borderColor = CGColor(red: 0, green: 43, blue: 17, alpha: 0.2)
            rightRoofButtonOutlet.tintColor = .white
            
        }
    }
    
    @IBOutlet weak var leftRoofImageView: UIImageView!
    @IBOutlet weak var rightRoofImageView: UIImageView!
    
    private var isleftRoofControlSet = true
    private var isRightRoofControlSet = true
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Roof Control"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        
       
        
        leftRoofButtonOutlet.setTitle("Open L Roof", for: .normal)
        rightRoofButtonOutlet.setTitle("Open R Roof", for: .normal)
        leftRoofButtonOutlet.backgroundColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
        rightRoofButtonOutlet.backgroundColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
        
        
        
       

    }
    
    
    @IBAction func leftRoofGarageButton(_ sender: Any) {
        
        if isleftRoofControlSet{
            isleftRoofControlSet = false
            
            var argument = ""
            
            if leftRoofButtonOutlet.title(for: .normal) == "Open L Roof" {
                leftRoofButtonOutlet.setTitle("Opening L Roof...", for: .normal)
                argument = "1"
            } else {
                leftRoofButtonOutlet.setTitle("Closing L Roof...", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("leftRoofState", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if (returnValue as? Int) == 1 {
                        
                        self.leftRoofButtonOutlet.setTitle("Close L Roof", for: .normal)
                        
                    }else if (returnValue as? Int) == 0 {
                        
                        self.leftRoofButtonOutlet.setTitle("Open L Roof", for: .normal)
                    }else{
                        if self.leftRoofButtonOutlet.title(for: .normal) == "Opening L Roof..." {
                            self.leftRoofButtonOutlet.setTitle("Open L Roof", for: .normal)
                        }else{
                            self.leftRoofButtonOutlet.setTitle("Close L Roof", for: .normal)
                        }
                    }
                    
                    
                }
                self.isleftRoofControlSet = true
            })
            
            
            
            
            
        }
        
        
        
    }
    
    
    @IBAction func rightRoofGarageButton(_ sender: Any) {
        if isRightRoofControlSet{
            isRightRoofControlSet = false
            
            var argument = ""
            
            if rightRoofButtonOutlet.title(for: .normal) == "Open R Roof" {
                rightRoofButtonOutlet.setTitle("Opening R Roof...", for: .normal)
                argument = "1"
            } else {
                rightRoofButtonOutlet.setTitle("Closing R Roof...", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("rightRoofState", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if (returnValue as? Int) == 1 {
                      
                        self.rightRoofButtonOutlet.setTitle("Close R Roof", for: .normal)
                        
                    }else if (returnValue as? Int) == 0 {
                        
                        }
                        self.rightRoofButtonOutlet.setTitle("Open R Roof", for: .normal)
                    }else{
                        if self.rightRoofButtonOutlet.title(for: .normal) == "Opening R Roof..." {
                            self.rightRoofButtonOutlet.setTitle("Open R Roof", for: .normal)
                        }else{
                            self.rightRoofButtonOutlet.setTitle("Close R Roof", for: .normal)
                        }
                    }
                    
                    self.isRightRoofControlSet = true
                })
            }
            
    }
            
            
            
        }
        
    
    


