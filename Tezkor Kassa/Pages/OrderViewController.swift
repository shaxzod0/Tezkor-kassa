//
//  OrderViewController.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 14/12/21.
//

import UIKit
import Lottie

let regionsUrl = "http://arzonkassa.com/api/order"

class OrderViewController: UIViewController {
    let coreManager = CoreDataManager.shared
    var item: Tickets?
    var animationView: AnimationView!
    let priceLabel = UILabel()
    let phoneNumberTextField = UITextField()
    let nameTextField = UITextField()
    let favButtton = UIButton()
    var buttonCounter = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        animationView = .init(name: "ticket_back")
        animationView!.frame = view.bounds
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
        initViews()
        view.sendSubviewToBack(animationView)
    }
}

extension OrderViewController{
    private func initViews(){
        let ticketNumberLabel = UILabel()
        view.addSubview(ticketNumberLabel)
        ticketNumberLabel.text = "Ticket №\(item?.id ?? "1")"
        ticketNumberLabel.font = .systemFont(ofSize: 25, weight: .bold)
        ticketNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        view.addSubview(favButtton)
        favButtton.setImage(UIImage(named: "favoriteIcon"), for: .normal)
        favButtton.addTarget(self, action: #selector(addFav), for: .touchUpInside)
        favButtton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        let infoView = UIStackView()
        view.addSubview(infoView)
        infoView.axis = .vertical
        infoView.distribution = .fillEqually
        infoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(ticketNumberLabel.snp.bottom).offset(20)
            make.height.equalTo(100)
        }
        
        let fromInfoView = UIView()
        infoView.addArrangedSubview(fromInfoView)
        fromInfoView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        let fromDateLabel = UILabel()
        fromInfoView.addSubview(fromDateLabel)
        fromDateLabel.text = item?.date
        fromDateLabel.font = .systemFont(ofSize: 14)
        fromDateLabel.textColor = .gray
        fromDateLabel.snp.makeConstraints { make in
            make.left.equalTo(fromInfoView).offset(20)
            make.centerY.equalTo(fromInfoView)
            make.width.equalTo(100)
        }
        
        let fromTimeLabel = UILabel()
        fromInfoView.addSubview(fromTimeLabel)
        fromTimeLabel.text = item?.time_go
        fromTimeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        fromTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(fromDateLabel.snp.bottom)
            make.left.equalTo(fromInfoView).inset(20)
            make.width.equalTo(100)
        }
        
        let planeImageFrom = UIImageView()
        fromInfoView.addSubview(planeImageFrom)
        planeImageFrom.image = UIImage(named: "planefrom")
        planeImageFrom.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.left.equalTo(fromDateLabel.snp.right)
            make.bottom.equalTo(fromInfoView.snp.bottom)
        }
        let textFrom = UILabel()
        fromInfoView.addSubview(textFrom)
        textFrom.text = "dan"
        textFrom.textColor = .gray
        textFrom.font = .systemFont(ofSize: 14)
        textFrom.snp.makeConstraints { make in
            make.left.equalTo(planeImageFrom.snp.right).offset(20)
            make.centerY.equalTo(fromInfoView)
            make.width.equalTo(60)
        }
        
        let fromCityInfo = UILabel()
        fromInfoView.addSubview(fromCityInfo)
        fromCityInfo.text = "\(item?.from_id ?? "") - \(item?.from_short ?? "")"
        fromCityInfo.textColor = .black
        fromCityInfo.snp.makeConstraints { make in
            make.top.equalTo(textFrom.snp.bottom)
            make.left.equalTo(planeImageFrom.snp.right).offset(20)
        }
        let toInfoView = UIView()
        infoView.addArrangedSubview(toInfoView)
        let toDateLabel = UILabel()
        toInfoView.addSubview(toDateLabel)
        toDateLabel.text = item?.date
        toDateLabel.font = .systemFont(ofSize: 14)
        toDateLabel.textColor = .gray
        toDateLabel.snp.makeConstraints { make in
            make.left.equalTo(toInfoView).offset(20)
            make.centerY.equalTo(toInfoView)
            make.width.equalTo(100)
        }
        
        let toTimeLabel = UILabel()
        toInfoView.addSubview(toTimeLabel)
        toTimeLabel.text = item?.time_arrive
        toTimeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        toTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(toDateLabel.snp.bottom)
            make.left.equalTo(toInfoView).inset(20)
            make.width.equalTo(100)
        }
        let planeImageTo = UIImageView()
        toInfoView.addSubview(planeImageTo)
        planeImageTo.transform = planeImageTo.transform.rotated(by: .pi/2)
        planeImageTo.image = UIImage(named: "planefrom")
        planeImageTo.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.left.equalTo(toDateLabel.snp.right)
            make.bottom.equalTo(toInfoView.snp.bottom)
        }
        let textTo = UILabel()
        toInfoView.addSubview(textTo)
        textTo.text = "ga"
        textTo.textColor = .gray
        textTo.font = .systemFont(ofSize: 14)
        textTo.snp.makeConstraints { make in
            make.left.equalTo(planeImageTo.snp.right).offset(20)
            make.centerY.equalTo(toInfoView)
            make.width.equalTo(60)
        }
        
        let toCityInfo = UILabel()
        fromInfoView.addSubview(toCityInfo)
        toCityInfo.text = "\(item?.to_id ?? "") - \(item?.to_short ?? "")"
        toCityInfo.textColor = .black
        toCityInfo.snp.makeConstraints { make in
            make.top.equalTo(textTo.snp.bottom)
            make.left.equalTo(planeImageTo.snp.right).offset(20)
        }
        
        
        view.addSubview(priceLabel)
        priceLabel.text = item?.price
        priceLabel.textColor = .mainTextColor
        priceLabel.font = .systemFont(ofSize: 25, weight: .bold)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
        }
        
        
        
        view.addSubview(nameTextField)
        nameTextField.placeholder = "Ism"
        nameTextField.layer.cornerRadius = 5
        nameTextField.setLeftImage(imageName: "accaunt")
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderColor = UIColor.mainTextColor.cgColor
        nameTextField.layer.borderWidth = 2
        nameTextField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.text = "+998"
        phoneNumberTextField.placeholder = "Phone number"
        phoneNumberTextField.setLeftImage(imageName: "phone")
        phoneNumberTextField.layer.cornerRadius = 5
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.layer.borderColor = UIColor.mainTextColor.cgColor
        phoneNumberTextField.layer.borderWidth = 2
        phoneNumberTextField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        let orderButton = UIButton()
        view.addSubview(orderButton)
        orderButton.setTitle("BUYURTMA QILISH", for: .normal)
        orderButton.backgroundColor = .mainTextColor
        orderButton.layer.cornerRadius = 5
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.right.left.equalToSuperview().inset(25)
            make.height.equalTo(50)
        }
        guard let number = phoneNumberTextField.text, !number.isEmpty else{
            phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        orderButton.addTarget(self, action: #selector(send), for: .touchUpInside)
        
    }
    
    
    @objc func send(){
        if phoneNumberTextField.text == "+998" {
            emptyPhoneAlert()
            phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
        }else{
            showAlertController(message: "Haridingiz uchun rahmat", subText: "Biz siz bilan tez orada bog'lanamiz")
            phoneNumberTextField.text = ""
        }
    }
    @objc func addFav(){
        coreManager.addFav(product: item!) { res in
            switch res{
            case .success(_):
                print("Saved")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        favButtton.setImage(UIImage(named: "favoriteIconSelected"), for: .normal)
    }
    func showAlertController(message: String, subText: String){
        let alert = UIAlertController(title: "\(message)", message: "\(subText)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: .none))
        present(alert, animated: true, completion: nil)
    }
    func emptyPhoneAlert(){
        let alert = UIAlertController(title: "Hatolik yuz berdi", message: "Iltimos telefon raqamingizni kiriting", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: .none))
        present(alert, animated: true)
    }
}



extension UITextField{
    func setLeftImage(imageName:String) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
    }
}
