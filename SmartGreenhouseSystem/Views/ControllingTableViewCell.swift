//
//  ControllingTableViewCell.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 23.11.2020.
//

import UIKit

protocol ControllingTableViewCellDelegate {
    func didChangeValueOfSlider(sliderControl: UISlider, atIndexPath indexPath: IndexPath)
    func didSwitchLightRateSwitch(switchControl: UISwitch, atIndexPath indexPath: IndexPath)
    func didSwicthOnOfSwitch(switchControl: UISwitch, atIndexPath indexPath: IndexPath)
}


class ControllingTableViewCell: UITableViewCell {

    private let cellTitleLabel = UILabel.newAutoLayout()
    private let cellOnOffSwitch = UISwitch.newAutoLayout()
    private let cellOnOffSlider = UISlider.newAutoLayout()
    private let cellLightRateSwitch = UISwitch.newAutoLayout()
    var indexPath: IndexPath!
    var isProcessing: Bool = false
    
    var delegate: ControllingTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let cellContentView = UIView.newAutoLayout()
        cellContentView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellContentView.layer.borderWidth = 1.5
        cellContentView.layer.cornerRadius = 5.0
        self.addSubview(cellContentView)
        
        cellContentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0))
        
        
        cellTitleLabel.textAlignment = .left
        cellTitleLabel.adjustsFontSizeToFitWidth = true
        cellTitleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        cellTitleLabel.textColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellTitleLabel.text = "Buzzer"
        cellContentView.addSubview(cellTitleLabel)
        
        cellTitleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 0.0, right: 5.0), excludingEdge: .bottom)
        cellTitleLabel.autoSetDimension(.height, toSize: 17)
        
        
        let cellLightView = UIView.newAutoLayout()
        cellLightView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellLightView.layer.borderWidth = 0.5
        cellLightView.layer.cornerRadius = 3.0
        cellContentView.addSubview(cellLightView)
        
        cellLightView.autoPinEdge(.top, to: .bottom, of: cellTitleLabel, withOffset: 2.0)
        cellLightView.autoPinEdge(toSuperviewEdge: .left, withInset: 5.0)
        cellLightView.autoPinEdge(toSuperviewEdge: .right, withInset: 5.0)
        cellLightView.autoSetDimension(.height, toSize: 77.0)

        cellOnOffSwitch.onTintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellOnOffSwitch.addTarget(self, action: #selector(didSwitchOnOffSwitch(sender:)), for: .valueChanged)
        cellOnOffSwitch.tintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellLightView.addSubview(cellOnOffSwitch)
        
        cellOnOffSwitch.autoPinEdge(toSuperviewEdge: .top, withInset: 5.0)
        cellOnOffSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 5.0)
        
        
        let cellOnOffLabel = UILabel.newAutoLayout()
        cellOnOffLabel.textAlignment = .left
        cellOnOffLabel.adjustsFontSizeToFitWidth = true
        cellOnOffLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        cellOnOffLabel.textColor = UIColor.gray
        cellOnOffLabel.text = "On / Off"
        cellLightView.addSubview(cellOnOffLabel)
        
        cellOnOffLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 5.0)
        cellOnOffLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 5.0)
        cellOnOffLabel.autoPinEdge(.right, to: .left, of: cellOnOffSwitch, withOffset: 5.0)
        cellOnOffLabel.autoSetDimension(.height, toSize: 31.0)
        
        
        cellOnOffSlider.tintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellOnOffSlider.minimumValue = 0.0
        cellOnOffSlider.maximumValue = 255.0
        cellOnOffSlider.isContinuous = false
        cellOnOffSlider.isEnabled = false
        cellOnOffSlider.addTarget(self, action: #selector(didOnOffSliderValueChanged(sender:)), for: .valueChanged)
        cellLightView.addSubview(cellOnOffSlider)
        
        cellOnOffSlider.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0.0, left: 5.0, bottom: 5.0, right: 5.0), excludingEdge: .top)
        cellOnOffSlider.autoPinEdge(.top, to: .bottom, of: cellOnOffLabel, withOffset: 5.0)
        
        
        let cellLightRateView = UIView.newAutoLayout()
        cellLightRateView.layer.borderColor = CGColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellLightRateView.layer.borderWidth = 0.5
        cellLightRateView.layer.cornerRadius = 3.0
        cellContentView.addSubview(cellLightRateView)
        
        cellLightRateView.autoPinEdge(.top, to: .bottom, of: cellLightView, withOffset: 5.0)
        cellLightRateView.autoPinEdge(toSuperviewEdge: .left, withInset: 5.0)
        cellLightRateView.autoPinEdge(toSuperviewEdge: .right, withInset: 5.0)
        cellLightRateView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5.0)
        
        
        cellLightRateSwitch.onTintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellLightRateSwitch.addTarget(self, action: #selector(didSwitchLightRateSwitch(sender:)), for: .valueChanged)
        cellLightRateSwitch.tintColor = UIColor(red: 0.0, green: 0.17, blue: 0.07, alpha: 0.20)
        cellLightRateView.addSubview(cellLightRateSwitch)
        
        cellLightRateSwitch.autoPinEdge(toSuperviewEdge: .top, withInset: 5.0)
        cellLightRateSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 5.0)
        
        
        let cellLightRateLabel = UILabel.newAutoLayout()
        cellLightRateLabel.textAlignment = .left
        cellLightRateLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        cellLightRateLabel.textColor = .gray
        cellLightRateLabel.text = "Set Light For Light Rate"
        cellLightRateView.addSubview(cellLightRateLabel)
        
        cellLightRateLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 0.0), excludingEdge: .right)
        cellLightRateLabel.autoPinEdge(.right, to: .left, of: cellLightRateSwitch, withOffset: 5.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellContent(cellTitle: String, indexPath: IndexPath) {
        cellTitleLabel.text = cellTitle
        self.indexPath = indexPath
    }
    
    func setOnToOnOffSwitch(on: Bool) {
        if on {
            cellOnOffSlider.isEnabled = true
            cellLightRateSwitch.setOn(false, animated: true)
            cellOnOffSlider.setValue(50.0, animated: true)
        } else {
            cellOnOffSlider.isEnabled = false
            cellOnOffSlider.setValue(0.0, animated: true)
        }
    }
    
    func setOnToLightRateSwitch(on: Bool) {
        if on {
            cellOnOffSlider.isEnabled = false
            cellOnOffSlider.setValue(0.0, animated: true)
            cellOnOffSwitch.setOn(false, animated: true)
        }
    }
    
    // MARK: - Getters
    func getSliderValue() -> Int {
        return Int(self.cellOnOffSlider.value)
    }
    
    // MARK: - Switch and SLider Actions
    @objc func didSwitchOnOffSwitch(sender: UISwitch) {
        self.setOnToOnOffSwitch(on: sender.isOn)
        delegate?.didSwicthOnOfSwitch(switchControl: sender, atIndexPath: indexPath)
    }
    
    @objc func didSwitchLightRateSwitch(sender: UISwitch) {
        self.setOnToLightRateSwitch(on: sender.isOn)
        delegate?.didSwitchLightRateSwitch(switchControl: sender, atIndexPath: indexPath)
    }
    
    @objc func didOnOffSliderValueChanged(sender: UISlider) {
        delegate?.didChangeValueOfSlider(sliderControl: sender, atIndexPath: indexPath)
    }
}

