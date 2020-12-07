//
//  MonitoringViewController.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 22.11.2020.
//

import UIKit
import UserNotifications

struct MonitoringCellData {
    let cellImage: String
    let cellTitle: String
    var cellValue: Float
    let cellValueType: String
}



class MonitoringViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MonitoringCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setCellContent(cellData: cellData[indexPath.row])
        return cell
        
    }
    
    
    
    
    var collectionView : UICollectionView!
    var reuseIdentifier = "collectionViewCell"
    
    let screenFrame = UIScreen.main.bounds
    let cellSize = CGSize(width: (UIScreen.main.bounds.width - 45) / 2, height: 130)

    var timer: Timer?
    
    var cellData: [MonitoringCellData] = [
        MonitoringCellData(cellImage: "heat", cellTitle: "Temperature", cellValue: 0.0, cellValueType: "Celcius"),
        MonitoringCellData(cellImage: "humidity", cellTitle: "Humidity", cellValue: 0.0, cellValueType: "Percent"),
        MonitoringCellData(cellImage: "soil", cellTitle: "Soil Moisture", cellValue: 0.0, cellValueType: "Percent"),
        MonitoringCellData(cellImage: "water-level", cellTitle: "Water Level", cellValue: 0.0, cellValueType: "Percent"),
        MonitoringCellData(cellImage: "fire", cellTitle: "Fire", cellValue: 0.0, cellValueType: "Status"),
        MonitoringCellData(cellImage: "gasRate", cellTitle: "Gas Rate", cellValue: 0.0, cellValueType: "Percent"),
        MonitoringCellData(cellImage: "night", cellTitle: "Time", cellValue: 0.0, cellValueType: "Day-Night"),
        MonitoringCellData(cellImage: "rain", cellTitle: "Rain", cellValue: 0.0, cellValueType: "Weather") ]
    
    
    var isTemperatureSet = true
    var isHumiditySet = true
    var isSoilMouistureSet = true
    var isWaterLevelSet = true
    var isFireSet = true
    var isGasSet = true
    var isTimeSet = true
    var isRainSet = true
                                          
                                          

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Monitoring"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        

        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.register(MonitoringCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(getDeviceVariables), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
   
    
    @objc func getDeviceVariables() {
        if isTemperatureSet {
            isTemperatureSet = false
            Device.sharedInstance.device?.getVariable("temp", completion: { (result, error) in
                if let error = error {
                    print("Temperature get error: \(error.localizedDescription)")
                    return
                }
                guard let floatResult = result as? Float else {
                    print("Temp Value is incorrect. Should be float")
                    return
                }
                
                self.cellData[0].cellValue = floatResult
                self.collectionView.reloadData()
                self.isTemperatureSet = true
            })
        }
        
        if isHumiditySet {
            isHumiditySet = false
            Device.sharedInstance.device?.getVariable("hum", completion: { (result, error) in
                if let error = error {
                    print("Hum get error: \(error.localizedDescription)")
                    return
                }
                
                guard let floatResult = result as? Float else {
                    print("Humidity value cant read")
                    return
                }
                
                self.cellData[1].cellValue = floatResult
                self.collectionView.reloadData()
                self.isHumiditySet = true
            })
        }
        
        if isSoilMouistureSet{
            isSoilMouistureSet = false
            Device.sharedInstance.device?.getVariable("soilMo", completion: { (result, error) in
                if let error = error {
                    print("Soil mouisture error : \(error.localizedDescription)")
                    return
                }
                
                guard let floatResult = result as? Float else {
                    print("Soil Mouisture Rate is incorrect")
                    return
                }
                self.cellData[2].cellValue = floatResult
                self.collectionView.reloadData()
                self.isSoilMouistureSet = true
            })
        }
        
        if isWaterLevelSet{
            isWaterLevelSet = false
            Device.sharedInstance.device?.getVariable("waterLevel", completion: { (result, error) in
                if let error = error {
                    print("Water  level error : \(error.localizedDescription)")
                    return
                }
                
                guard let floatResult = result as? Float else {
                    print("Water Level Rate is incorrect")
                    return
                }
                self.cellData[3].cellValue = floatResult
                self.collectionView.reloadData()
                self.isWaterLevelSet = true
            })
        }
        
        if isFireSet{
            isFireSet = false
            Device.sharedInstance.device?.getVariable("fire", completion: { (result, error) in
                if let error = error {
                    print("Fire sensor error : \(error.localizedDescription)")
                    return
                }
                
                guard let floatResult = result as? Float else {
                    print("Fire sensor rate is incorrect")
                    return
                }
                self.cellData[4].cellValue = floatResult
                self.collectionView.reloadData()
                self.isFireSet = true
            })
        }
        
        if isGasSet{
            isGasSet = false
            Device.sharedInstance.device?.getVariable("gas", completion: { (result, error) in
                if let error = error {
                    print("Gas sensor error : \(error.localizedDescription)")
                    return
                }
                
                guard let floatResult = result as? Float else {
                    print("Gas rate is incorrect")
                    return
                }
                self.cellData[5].cellValue = floatResult
                self.collectionView.reloadData()
                self.isGasSet = true
            })
        }
        
        if isTimeSet{
            isTimeSet = false
            Device.sharedInstance.device?.getVariable("ldr", completion: { (result, error) in
                if let error = error {
                    print("Ldr sensor error : \(error.localizedDescription)")
                    return
                }
                
                guard let floatResult = result as? Float else {
                    print("Ldr rate is incorrect")
                    return
                }
                self.cellData[6].cellValue = floatResult
                self.collectionView.reloadData()
                self.isTimeSet = true
            })
        }
        
        if isRainSet{
            isRainSet = false
            Device.sharedInstance.device?.getVariable("rain", completion: { (result, error) in
                if let error = error {
                    print("Rain sensor error : \(error.localizedDescription)")
                    return
                }
                
                guard let floatResult = result as? Float else {
                    print("Rain rate is incorrect")
                    return
                }
                self.cellData[7].cellValue = floatResult
                self.collectionView.reloadData()
                self.isRainSet = true
            })
        }
        
    }
    
    

   

}

extension MonitoringViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
