//
//  ViewController.swift
//  Tezkor Kassa
//
//  Created by Shaxzod Azamatjonov on 07/04/22.
//
import UIKit
import Lottie
import SnapKit

class ViewController: UIViewController {
    
    var animationView: AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "loading")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1.0
        view.addSubview(animationView!)
        animationView!.play()
        animationView!.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(200)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let vc = UINavigationController(rootViewController: TabViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true) {
                self.animationView?.stop()
                self.animationView = nil
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
}

