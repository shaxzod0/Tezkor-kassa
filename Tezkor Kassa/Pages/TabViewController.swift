//
//  TabViewController.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 14/12/21.
//

import UIKit
import SnapKit
import Lottie

class TabViewController: UITabBarController {
    var animationView: AnimationView!
    
    let sideMenuView = SideMenuView()
    var isSideMenuClosed = true
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.barTintColor = .milkColor
        animationView = .init(name: "ticket_back")
        animationView!.frame = view.bounds
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView!.snp.makeConstraints { make in
            make.bottom.equalTo(tabBar.snp.top).offset(10)
            make.left.right.top.equalToSuperview()
        }
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play(completion: nil)
        initViews()
        initNavigationView()
        initSideMenu()
        view.sendSubviewToBack(animationView)
    }
}

extension TabViewController{
    private func initViews(){
        let mainPage = MainViewController()
        mainPage.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "homeIcon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:"homeIconSelected")?.withRenderingMode(.alwaysOriginal))
        let favoritePage = FavoriteViewController()
        favoritePage.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favoriteIcon")?.withRenderingMode(.alwaysOriginal), selectedImage:UIImage(named: "favoriteIconSelected")?.withRenderingMode(.alwaysOriginal))
        let settingsPage = SettingsViewController()
        settingsPage.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "settingsIcon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settingsIconSelected")?.withRenderingMode(.alwaysOriginal))
        
        tabBar.backgroundColor = .milkColor
        tabBar.layer.cornerRadius = 10
        tabBar.clipsToBounds = true
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewControllers = [mainPage,favoritePage,settingsPage]//.map{UINavigationController(rootViewController: $0)}
    }
    

    private func initNavigationView(){
        let leftMenuButton = UIBarButtonItem(image: UIImage(named: "sideMenuIcon")?.withRenderingMode(.alwaysOriginal), style: .done, target:self , action: #selector(sideMenuController))

        let logoLabel = UILabel()
        logoLabel.text = "TEZKOR KASSA"
        logoLabel.textColor = .mainTextColor
        logoLabel.font = .systemFont(ofSize: 25, weight: .bold)


        navigationItem.titleView = logoLabel
        navigationItem.leftBarButtonItem = leftMenuButton
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.navigationBar.prefersLargeTitles = false

           let appearance = UINavigationBarAppearance()
           appearance.backgroundColor = .milkColor
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

           navigationController?.navigationBar.tintColor = .white
           navigationController?.navigationBar.standardAppearance = appearance
           navigationController?.navigationBar.compactAppearance = appearance
           navigationController?.navigationBar.scrollEdgeAppearance = appearance
   }
    private func initSideMenu(){
        view.addSubview(sideMenuView)
        sideMenuView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        sideMenuView.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
        view.bringSubviewToFront(sideMenuView)
    }
    @objc func sideMenuController(){
        UIView.transition(with: sideMenuView, duration: 0.2, options: .curveEaseIn) {
            self.sideMenuView.transform = self.isSideMenuClosed ? .identity : CGAffineTransform(translationX: -self.sideMenuView.frame.width, y: 0)
        } completion: { s in
            self.isSideMenuClosed = !self.isSideMenuClosed
        }
    }
    @objc func sideMenuAvatarAction(){
        let orderNavigationVC = OrderViewController()
        navigationController?.navigationBar.tintColor = .mainTextColor
        navigationController?.pushViewController(orderNavigationVC, animated: true)
    }
    
    
}
