//
//  HeaderView.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 06/01/22.
//

import UIKit

class HeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame )
        self.backgroundColor = .milkColor
        let logoImage = UIImageView()
        self.addSubview(logoImage)
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode = .scaleAspectFit
        logoImage.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.center.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
