//
//  Model.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 12/01/22.
//

import UIKit

struct Tickets: Codable{
    let from_id: String
    let to_id: String
    let date: String
    let price: String
    let time_go: String
    let time_arrive: String
    let id: String
    let from_short: String
    let to_short: String
}
