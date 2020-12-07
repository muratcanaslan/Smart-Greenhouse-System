//
//  ControllingViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 22.11.2020.
//

import UIKit
import Particle_SDK



class ControllingViewController: UIViewController {
    
    var isBuzzerSet:Bool = true
    var isWaterPumpSet:Bool = true
    var isRedButtonSet = true
    var isGreenButtonSet = true
    var isBlueButtonSet = true
    var isYellowButtonSet = true
    var isSilverButtonSet = true
    var isCyanButtonSet = true
    var isMagentaButtonSet = true
    var isWhiteButtonSet = true
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelWaterPump: UILabel!
    
    @IBOutlet weak var waterPumpView: UIView!
    @IBOutlet weak var buzzerView: UIView!
    @IBOutlet weak var systemLightingView: UIView!
    
    @IBOutlet weak var buzzerButton: UIButton!
    @IBOutlet weak var waterPumpButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var silverButton: UIButton!
    @IBOutlet weak var cyanButton: UIButton!
    @IBOutlet weak var magentaButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Controlling"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        
        waterPumpButton.setTitle("Open", for: .normal)
        buzzerButton.setTitle("Open", for: .normal)
        redButton.setTitle("Open", for: .normal)
        greenButton.setTitle("Open", for: .normal)
        blueButton.setTitle("Open", for: .normal)
        yellowButton.setTitle("Open", for: .normal)
        whiteButton.setTitle("Open", for: .normal)
        magentaButton.setTitle("Open", for: .normal)
        cyanButton.setTitle("Open", for: .normal)
        silverButton.setTitle("Open", for: .normal)

        
        
        buzzerView.layer.borderWidth = 4
        buzzerView.layer.cornerRadius = 10
        buzzerView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
        waterPumpView.layer.borderWidth = 4
        waterPumpView.layer.cornerRadius = 10
        waterPumpView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
        
        systemLightingView.layer.borderWidth = 4
        systemLightingView.layer.cornerRadius = 10
        systemLightingView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 1)
        
        
        
        
        
        
       
    }
    @IBAction func buzzerOnOffButton(_ sender: Any) {
        if isBuzzerSet{
            isBuzzerSet = false
            var argument = ""
            
            if buzzerButton.title(for: .normal) == "Open" {
                buzzerButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                buzzerButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("openCloseBuzzer", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.buzzerButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.buzzerButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.buzzerButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.buzzerButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.buzzerButton.title(for: .normal) == "Opening" {
                            self.buzzerButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.buzzerButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.buzzerButton.title(for: .normal) == "Opening" {
                        self.buzzerButton.setTitle("Open", for: .normal)
                    }else {
                        self.buzzerButton.setTitle("Close", for: .normal)
                    }
                }
                self.isBuzzerSet = true
            })
        }
    }
    
    
    
    @IBAction func waterPumpOnOffButton(_ sender: Any) {
        if isWaterPumpSet{
            isWaterPumpSet = false
            var argument = ""
            
            if waterPumpButton.title(for: .normal) == "Open" {
                waterPumpButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                waterPumpButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("openCloseWaterPump", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.waterPumpButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.waterPumpButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.waterPumpButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.waterPumpButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.waterPumpButton.title(for: .normal) == "Opening" {
                            self.waterPumpButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.waterPumpButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.waterPumpButton.title(for: .normal) == "Opening" {
                        self.waterPumpButton.setTitle("Open", for: .normal)
                    }else {
                        self.waterPumpButton.setTitle("Close", for: .normal)
                    }
                }
                self.isWaterPumpSet = true
            })
        }
    }
    
    @IBAction func redClickedButton(_ sender: Any) {
        if isRedButtonSet{
            isRedButtonSet = false
            var argument = ""
            
            if redButton.title(for: .normal) == "Open" {
                redButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                redButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingRed", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.redButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.redButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.redButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.redButton.title(for: .normal) == "Opening" {
                            self.redButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.redButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.redButton.title(for: .normal) == "Opening" {
                        self.redButton.setTitle("Open", for: .normal)
                    }else {
                        self.redButton.setTitle("Close", for: .normal)
                    }
                }
                self.isRedButtonSet = true
            })
        }
    }
    @IBAction func greenClickedButton(_ sender: Any) {
        if isGreenButtonSet{
            isGreenButtonSet = false
            var argument = ""
            
            if greenButton.title(for: .normal) == "Open" {
                greenButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                greenButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingGreen", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.greenButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)


                        self.greenButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.greenButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.greenButton.title(for: .normal) == "Opening" {
                            self.greenButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.greenButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.greenButton.title(for: .normal) == "Opening" {
                        self.greenButton.setTitle("Open", for: .normal)
                    }else {
                        self.greenButton.setTitle("Close", for: .normal)
                    }
                }
                self.isGreenButtonSet = true
            })
        }
    }
    @IBAction func blueClickedButton(_ sender: Any) {
        if isBlueButtonSet{
            isBlueButtonSet = false
            var argument = ""
            
            if blueButton.title(for: .normal) == "Open" {
                blueButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                blueButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingBlue", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.redButton.setTitle("Close", for: .normal)
                        self.blueButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.blueButton.title(for: .normal) == "Opening" {
                            self.blueButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.blueButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.blueButton.title(for: .normal) == "Opening" {
                        self.blueButton.setTitle("Open", for: .normal)
                    }else {
                        self.blueButton.setTitle("Close", for: .normal)
                    }
                }
                self.isBlueButtonSet = true
            })
        }
    }
    @IBAction func yellowClickedButton(_ sender: Any) {
        if isYellowButtonSet{
            isYellowButtonSet = false
            var argument = ""
            
            if yellowButton.title(for: .normal) == "Open" {
                yellowButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                yellowButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingYellow", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.redButton.setTitle("Close", for: .normal)
                        self.yellowButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.yellowButton.title(for: .normal) == "Opening" {
                            self.yellowButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.yellowButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.yellowButton.title(for: .normal) == "Opening" {
                        self.yellowButton.setTitle("Open", for: .normal)
                    }else {
                        self.yellowButton.setTitle("Close", for: .normal)
                    }
                }
                self.isYellowButtonSet = true
            })
        }
    }
    @IBAction func silverClickedButton(_ sender: Any) {
        if isSilverButtonSet{
            isSilverButtonSet = false
            var argument = ""
            
            if silverButton.title(for: .normal) == "Open" {
                silverButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                silverButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingSilver", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.redButton.setTitle("Close", for: .normal)
                        self.silverButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.silverButton.title(for: .normal) == "Opening" {
                            self.silverButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.silverButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.silverButton.title(for: .normal) == "Opening" {
                        self.silverButton.setTitle("Open", for: .normal)
                    }else {
                        self.silverButton.setTitle("Close", for: .normal)
                    }
                }
                self.isSilverButtonSet = true
            })
        }
    }
    @IBAction func cyanClickedButton(_ sender: Any) {
        if isCyanButtonSet{
            isCyanButtonSet = false
            var argument = ""
            
            if cyanButton.title(for: .normal) == "Open" {
                cyanButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                cyanButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingCyan", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.redButton.setTitle("Close", for: .normal)
                        self.cyanButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.cyanButton.title(for: .normal) == "Opening" {
                            self.cyanButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.cyanButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.cyanButton.title(for: .normal) == "Opening" {
                        self.cyanButton.setTitle("Open", for: .normal)
                    }else {
                        self.cyanButton.setTitle("Close", for: .normal)
                    }
                }
                self.isCyanButtonSet = true
            })
        }
    }
    @IBAction func magentaClickedButton(_ sender: Any) {
        if isMagentaButtonSet{
            isMagentaButtonSet = false
            var argument = ""
            
            if magentaButton.title(for: .normal) == "Open" {
                magentaButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                magentaButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingMagenta", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.redButton.setTitle("Close", for: .normal)
                        self.magentaButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.magentaButton.title(for: .normal) == "Opening" {
                            self.magentaButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.magentaButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.magentaButton.title(for: .normal) == "Opening" {
                        self.magentaButton.setTitle("Open", for: .normal)
                    }else {
                        self.magentaButton.setTitle("Close", for: .normal)
                    }
                }
                self.isMagentaButtonSet = true
            })
        }
    }
    @IBAction func whiteClickedButton(_ sender: Any) {
        if isWhiteButtonSet{
            isWhiteButtonSet = false
            var argument = ""
            
            if whiteButton.title(for: .normal) == "Open" {
                whiteButton.setTitle("Opening", for: .normal)
                argument = "1"
            }else{
                whiteButton.setTitle("Closing", for: .normal)
                argument = "0"
            }
            
            Device.sharedInstance.device?.callFunction("systemLightingWhite", withArguments: [argument], completion: { (returnValue, error) in
                if(error == nil && (returnValue as? Int) != nil) {
                    if(returnValue as? Int) == 1 {
                        self.redButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.greenButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setImage(UIImage(named: "offbutton"), for: .normal)
                        self.yellowButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.cyanButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.blueButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.magentaButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.silverButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.redButton.setTitle("Close", for: .normal)
                        self.whiteButton.setTitle("Close", for: .normal)
                    }else if (returnValue as? Int) == 0 {
                        self.whiteButton.setImage(UIImage(named: "onbutton"), for: .normal)
                        self.whiteButton.setTitle("Open", for: .normal)
                    }else{
                        if  self.whiteButton.title(for: .normal) == "Opening" {
                            self.whiteButton.setTitle("Open", for: .normal)
                            
                        }else{
                            self.whiteButton.setTitle("Close", for: .normal)
                        }
                    }
                }else{
                    if self.whiteButton.title(for: .normal) == "Opening" {
                        self.whiteButton.setTitle("Open", for: .normal)
                    }else {
                        self.whiteButton.setTitle("Close", for: .normal)
                    }
                }
                self.isWhiteButtonSet = true
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    }
    
    


