//
//  FavoriteCell.swift
//  Tezkor Kassa
//
//  Created by Shaxzod Azamatjonov on 08/04/22.
//

import UIKit

class FavoriteCell: UITableViewCell {
    let fromCity = UILabel()
    let toCity = UILabel()
    let dashLabel = UILabel()
    let priceLabel = UILabel()
    static let identifier = "tableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initViews(){
        self.addSubview(fromCity)
        self.addSubview(toCity)
        self.addSubview(dashLabel)
        self.addSubview(priceLabel)
        
        fromCity.text = "Something"
        fromCity.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        dashLabel.text = "-"
        dashLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(fromCity.snp.right).inset(-10)
        }
        toCity.text = "city"
        toCity.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(dashLabel.snp.right).inset(-10)
        }
        priceLabel.text = "500"
        priceLabel.textColor = .mainTextColor
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }

}
