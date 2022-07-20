//
//  MainViewController.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 14/12/21.
//

import UIKit
import Lottie


class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    weak var collectionView: UICollectionView!
    
    var ticketsData: [Tickets] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        initViews()
        getTickets()
    }
}

extension MainViewController{
    
    private func initViews(){
        let layoutTickets = UICollectionViewFlowLayout()
        layoutTickets.scrollDirection = .vertical
        layoutTickets.minimumLineSpacing = 15
        layoutTickets.minimumInteritemSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutTickets)
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: "TicketsCell", bundle: nil), forCellWithReuseIdentifier: "TicketsCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.collectionView = collectionView
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticketsData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketsCell", for: indexPath) as! TicketsCell
        cell.setItems(item: ticketsData[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) - 40
        return CGSize(width: width, height: 300 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let orderNavigationVC = OrderViewController()
        orderNavigationVC.item = ticketsData[indexPath.item]
        navigationController?.navigationBar.tintColor = .mainTextColor
        navigationController?.pushViewController(orderNavigationVC, animated: true)
    }
    
    func getTickets(){
        NetworkManager.shared.getTickets { res in
            DispatchQueue.main.async {
                self.ticketsData = res
                self.collectionView.reloadData()
            }
        }
    }
}
