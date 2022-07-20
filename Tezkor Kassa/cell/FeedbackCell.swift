//
//  FeedbackCell.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 06/01/22.
//

import UIKit

class FeedbackCell: UICollectionViewCell {

    @IBOutlet weak var iconFeedback: UIImageView!
    @IBOutlet weak var feedbackLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .milkColor
        self.layer.cornerRadius = 20
    }
    func setItem(item: feedback){
        iconFeedback.image = item.icon
        feedbackLabel.text = item.feedbackLabel
    }

}
struct feedback{
    let icon: UIImage
    let feedbackLabel: String
}
