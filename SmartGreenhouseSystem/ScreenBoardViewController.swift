//
//  ScreenBoardViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 21.11.2020.
//

import UIKit
import paper_onboarding


class ScreenBoardViewController: UIViewController {
    
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var onboardingView: PaperOnboarding!
    
    let itemArray = [
        OnboardingItemInfo(informationImage: UIImage(named: "monitor")!, title: "Monitoring", description: "You can see your current variables on Green Smarthouse System.", pageIcon: UIImage(named: "circle")!, color: .systemGreen, titleColor: .black, descriptionColor: .white, titleFont: UIFont(name: "AvenirNext-Bold", size: 23)!, descriptionFont: UIFont(name: "AvenirNext-Medium", size: 14)!),
        OnboardingItemInfo(informationImage: UIImage(named: "controlling")!, title: "Controlling", description: "You can remote control your  Green Smarthouse System.", pageIcon: UIImage(named: "circle")!, color: .systemPink, titleColor: .black, descriptionColor: .white, titleFont: UIFont(name: "AvenirNext-Bold", size: 23)!, descriptionFont: UIFont(name: "AvenirNext-Medium", size: 14)!),
        OnboardingItemInfo(informationImage: UIImage(named: "fruits")!, title: "Information", description: "You can read general information about Fruits and Vegetables.", pageIcon: UIImage(named: "circle")!, color: .systemBlue, titleColor: .black, descriptionColor: .white, titleFont: UIFont(name: "AvenirNext-Bold", size: 23)!, descriptionFont: UIFont(name: "AvenirNext-Medium", size: 14)!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        
        tutorialButton.titleLabel?.textAlignment = .center
        tutorialButton.backgroundColor = .lightText
    }
    
    
    @IBAction func tutorialButtonClicked(_ sender: Any) {
    }
    
    
    

    

}

extension ScreenBoardViewController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
          itemArray.count
         
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
          itemArray[index]
    }
}


