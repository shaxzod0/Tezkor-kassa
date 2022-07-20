//
//  DummyData.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 22/12/21.
//

import UIKit

struct DummyData {
    
    
    static let sideData: [sideMenu] = [
        sideMenu(icon: #imageLiteral(resourceName: "telegram"), title: "Telegram"),
        sideMenu(icon: #imageLiteral(resourceName: "instagram"), title: "Instagram"),
        sideMenu(icon: #imageLiteral(resourceName: "phone"), title: "Aloqa")
    ]
    
    
    static let feedbackData: [feedback] = [
        feedback(icon: #imageLiteral(resourceName: "telegram"), feedbackLabel: "Telegram"),
        feedback(icon: #imageLiteral(resourceName: "instagram"), feedbackLabel: "Instagram"),
        feedback(icon: #imageLiteral(resourceName: "phone"), feedbackLabel: "Aloqa")
    ]
}
