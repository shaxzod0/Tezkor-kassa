//
//  SideMenuView.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 15/12/21.
//

import UIKit
import SnapKit

class SideMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    let data = DummyData.sideData
    fileprivate let headerId = "headerId"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        initViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews(){
        let l = UICollectionViewFlowLayout()
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = 0
        l.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        self.addSubview(collectionView)
         collectionView.snp.makeConstraints { make in
             make.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellWithReuseIdentifier: "SideMenuCell")
        collectionView.register(HeaderView.self , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.setItems(item: data[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)->CGSize{
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.item == 0){
            goToTg()
        }
        else if (indexPath.item == 1){
            goToInst()
        }
        else if (indexPath.item == 2){
            callNumber(phoneNumber: "+998916035060")
        }
    }
    
    func goToTg(){
        if let url = URL(string: "https://t.me/tezkor_kassa_2022") {
            UIApplication.shared.open(url)
        }
    }
    func goToInst(){
        if let url = URL(string: "https://www.instagram.com/tezkor_kassa_/") {
            UIApplication.shared.open(url)
        }
    }
    private func callNumber(phoneNumber:String) {

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
}
