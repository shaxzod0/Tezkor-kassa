//
//  SettingsViewController.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 14/12/21.
//

import UIKit

class SettingsViewController: UIViewController {
    weak var collectionView: UICollectionView!
    let data = DummyData.feedbackData
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        initView()
    }
}

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    private func initView(){
        let layoutFeedback = UICollectionViewFlowLayout()
        layoutFeedback.scrollDirection = .vertical
        layoutFeedback.minimumLineSpacing = 10
        layoutFeedback.minimumInteritemSpacing = 10
        
        let feedbackCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFeedback)
        view.addSubview(feedbackCollectionView)
        feedbackCollectionView.register(UINib(nibName: "FeedbackCell", bundle: nil), forCellWithReuseIdentifier: "FeedbackCell")
        feedbackCollectionView.delegate = self
        feedbackCollectionView.dataSource = self
        feedbackCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView = feedbackCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedbackCell", for: indexPath) as! FeedbackCell
        cell.setItem(item: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width*0.8
        return CGSize(width: width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 20, bottom: 20, right: 20)
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
