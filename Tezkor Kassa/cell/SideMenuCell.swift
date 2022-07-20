//
//  SideMenuCell.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 30/12/21.
//

import UIKit

class SideMenuCell: UICollectionViewCell {
    
   
    
   
    @IBOutlet weak var iconImage: UIImageView!
    

    @IBOutlet weak var sideMenuButtons: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setItems(item: sideMenu){
        iconImage.image = item.icon
        sideMenuButtons.setTitle(item.title, for: .normal)
    }

}

struct sideMenu{
    let icon: UIImage
    let title: String
}
