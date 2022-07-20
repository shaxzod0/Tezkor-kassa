//
//  NetworkManager.swift
//  Tezkor Kassa
//
//  Created by Shaxzod Azamatjonov on 08/04/22.
//

import Foundation
import Alamofire
import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    func getTickets(compilationHandler: @escaping (([Tickets])->Void)){
        let url = AppUrl.base_url
        AF.request(url, method: .get).validate().responseDecodable(of: [Tickets].self){ res in
           
            guard let data = res.value else{
                print("Error value")
                return}
            compilationHandler(data)
        }
    }
}
