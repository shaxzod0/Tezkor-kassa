//
//  TicketsCell.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 20/12/21.
//

import UIKit
import Lottie

class TicketsCell: UICollectionViewCell {
    @IBOutlet weak var fromCityShortLabel: UILabel!
    @IBOutlet weak var toCityShortFormLabel: UILabel!
    @IBOutlet weak var arriveTimeLabel: UILabel!
    @IBOutlet weak var fromCityFullLabel: UILabel!
    @IBOutlet weak var toCityFullLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var arriveDateLabel: UILabel!
    @IBOutlet weak var priceTicket: UILabel!
    @IBOutlet weak var departDateLabel: UILabel!
    @IBOutlet weak var ticketNumber: UILabel!
    @IBOutlet weak var planeAnimationView: AnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        planeAnimationView.contentMode = .scaleAspectFit
        planeAnimationView.loopMode = .loop
        planeAnimationView.animationSpeed = 1
        planeAnimationView.backgroundBehavior = .pauseAndRestore
        planeAnimationView.play(completion: nil)
    }
    
    func setItems(item: Tickets){
        fromCityShortLabel.text = item.from_short
        fromCityFullLabel.text = item.from_id
        toCityShortFormLabel.text = item.to_short
        toCityFullLabel.text = item.to_id
        fromTimeLabel.text = item.time_go
        arriveTimeLabel.text = item.time_arrive
        departDateLabel.text = item.date
        arriveDateLabel.text = item.date
        ticketNumber.text = item.id
        priceTicket.text = item.price
        priceTicket.textColor = .mainTextColor
    }

}
