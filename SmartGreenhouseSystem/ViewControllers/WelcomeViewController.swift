//
//  WelcomeViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 21.11.2020.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var goToLoginPageLabel: UILabel!
    @IBOutlet weak var initiliazingVariables: UILabel!
    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var goToButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
        
        //Background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "tomato")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        backgroundImage.alpha = 0.7
        self.view.insertSubview(backgroundImage, at: 0)
        
        perform(#selector(goToScreen), with: nil, afterDelay: 2.0)

        
                
    }
    
    

    
    
    var startValue:Double = 0
    let endValue:Double = 100
    let animationDuration: Double = 1.5
    let animationStartDate = Date()
    
    @IBAction func goToLoginScreenButtonClicked(_ sender: Any) {
    }
    
    @objc func handleUpdate(){
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.countingLabel.text = "%\(endValue)"
            initiliazingVariables.text = "Tomate mode has been activiated."
            initiliazingVariables.textColor = UIColor.red
            goToButton.isHidden = true
            goToLoginPageLabel.isHidden = true
           
        }else{
            let percentage = elapsedTime / animationDuration
            let value = percentage * (endValue - startValue)
            self.countingLabel.text = "%\(value)"
            goToButton.isHidden = true
            goToLoginPageLabel.isHidden = true
            goToLoginPageLabel.text = "Click button to login page."
        }


    }
    @objc func goToScreen(){
        performSegue(withIdentifier: "toLoginView", sender: nil)

    }
    
    
    

}
