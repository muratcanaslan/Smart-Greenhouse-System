//
//  MonitoringCollectionViewCell.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 22.11.2020.
//

import UIKit
import PureLayout

class MonitoringCollectionViewCell: UICollectionViewCell {
    private let cellImageView = UIImageView.newAutoLayout()
    private let cellTitleLabel = UILabel.newAutoLayout()
    private let cellValueLabel = UILabel.newAutoLayout()
    private let cellDetailLabel = UILabel.newAutoLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10
        
        let upView = UIView.newAutoLayout()
        self.addSubview(upView)
        
        upView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        upView.autoAlignAxis(toSuperviewAxis: .vertical)
        upView.autoSetDimensions(to: CGSize(width: 110.0, height: 25.0))
        
        cellImageView.image = UIImage(named: "heat")
        cellImageView.contentMode = .scaleAspectFit
        upView.addSubview(cellImageView)
        
        cellImageView.autoPinEdge(toSuperviewEdge: .top)
        cellImageView.autoPinEdge(toSuperviewEdge: .left)
        
        cellTitleLabel.textAlignment = .center
        cellTitleLabel.adjustsFontSizeToFitWidth = true
        cellTitleLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        cellTitleLabel.textColor = .gray
        cellTitleLabel.text = "Temperature"
        upView.addSubview(cellTitleLabel)
        
        cellTitleLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        cellTitleLabel.autoPinEdge(.left, to: .right, of: cellImageView, withOffset: 5.0)
        cellTitleLabel.autoSetDimension(.height, toSize: 25)
        
        cellValueLabel.textAlignment = .center
        cellValueLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 55.0)
        cellValueLabel.adjustsFontSizeToFitWidth = true
        cellValueLabel.textColor = .black
        cellValueLabel.text = ""
        self.addSubview(cellValueLabel)
        
        cellValueLabel.autoPinEdge(.top, to: .bottom, of: upView, withOffset: 5)
        cellValueLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        cellValueLabel.autoSetDimension(.height, toSize: 60)
        
        cellDetailLabel.textAlignment = .center
        cellDetailLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        cellDetailLabel.adjustsFontSizeToFitWidth = true
        cellDetailLabel.textColor = .gray
        cellDetailLabel.text = "Celcius"
        self.addSubview(cellDetailLabel)
        
        cellDetailLabel.autoPinEdge(.top, to: .bottom, of: cellValueLabel, withOffset: 5)
        cellDetailLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        cellDetailLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellContent(cellData: MonitoringCellData) {
        cellImageView.image = UIImage(named: cellData.cellImage)
        cellTitleLabel.text = cellData.cellTitle
        
        if cellData.cellTitle == "Temperature" {
            cellValueLabel.text = String(format: "%2.1f", cellData.cellValue)
        }else{
            cellValueLabel.text = String(format: "%2.1f", cellData.cellValue)
        }
        
        if cellData.cellTitle == "Gas Rate" {
            if cellData.cellValue > 40.0 {
                cellValueLabel.textColor = .red
            }else{
                cellValueLabel.textColor = .black
            }
            
        }else {
            cellValueLabel.textColor = .black
        }
        
        if cellData.cellTitle == "SoilMouisture" {
            if cellData.cellValue < 40 {
                cellValueLabel.textColor = .red
            }else{
                cellValueLabel.textColor = .black
            }
        }else {
            cellValueLabel.textColor = .black
        }
        
        if cellData.cellTitle == "Fire"{
            if cellData.cellValue > 30 {
                cellValueLabel.textColor = .red
                cellValueLabel.text = "FIRE !"
                cellValueLabel.font = cellValueLabel.font.withSize(17)

            }else{
                cellValueLabel.textColor = .black
                cellValueLabel.text = "No Flame"
                cellValueLabel.font = cellValueLabel.font.withSize(17)

            }

        }else{
            cellValueLabel.textColor = .black
        }
        
        if cellData.cellTitle == "Rain"{
            switch cellData.cellValue {
            case 0...70:
                cellValueLabel.font = cellValueLabel.font.withSize(17)
                cellValueLabel.text = "No rain"
            case 71...100:
                cellValueLabel.font = cellValueLabel.font.withSize(17)
                cellValueLabel.textColor = .blue
                cellValueLabel.text = "Rain"
            default:
                print("Cant read rain rate.")
            }
        }
        
        if cellData.cellTitle == "Water Level" {
            if cellData.cellValue < 50 {
                cellValueLabel.textColor = .red
                
            }else{
                cellValueLabel.textColor = .black
            }
        }else{
            cellValueLabel.textColor = .black
        }
        
        if cellData.cellTitle == "Time" {
            if cellData.cellValue < 50{
                cellValueLabel.text = "Night"
                cellValueLabel.font = cellValueLabel.font.withSize(17)

            }
            else{
                cellValueLabel.text = "Day"
                cellValueLabel.font = cellValueLabel.font.withSize(17)

            }
            
        }
        
        

        
        
        
        
        cellDetailLabel.text = cellData.cellValueType
        
    }
}
