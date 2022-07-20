//
//  FavoriteViewController.swift
//  arzonKassa
//
//  Created by Shaxzod Azamatjonov on 14/12/21.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController{
    var tableView = UITableView()
    var productData: [NSManagedObject] = []
    let coreManager = CoreDataManager.shared
    var isDelete = true
    let clearFav = UIButton()
    let emptyLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        initViews()
        getTickets()
    }
    override func viewWillAppear(_ animated: Bool) {
        getTickets()
    }
}


extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{

    
    func getTickets(){
        coreManager.fetchFromFav { res in
            switch res{
            case .success(let data):
                self.productData = data
                self.tableView.reloadData()
                if self.productData.count == 0{
                    self.emptyLabel.isHidden = false
                }else{
                    self.emptyLabel.isHidden = true
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func initViews(){
        view.addSubview(tableView)
        view.addSubview(clearFav)
        view.addSubview(emptyLabel)
        emptyLabel.text = "Hozircha bo'sh"
        emptyLabel.textColor = .mainTextColor
        emptyLabel.isHidden = false
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        tableView.rowHeight = 100
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        clearFav.setTitle("Clear", for: .normal)
        clearFav.backgroundColor = .mainTextColor
        clearFav.layer.cornerRadius = 15
        clearFav.addTarget(self, action: #selector(clearFavor), for: .touchUpInside)
        clearFav.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as! FavoriteCell
        cell.priceLabel.text = productData[indexPath.row].value(forKey: "price") as? String
        cell.fromCity.text = productData[indexPath.row].value(forKey: "from_id") as? String
        cell.toCity.text = productData[indexPath.row].value(forKey: "to_id") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let deleteObject = productData[indexPath.row]
        if isDelete {
            coreManager.deleteObjejct(object: deleteObject as! Ticket)
            productData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath] , with: .automatic)
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderViewController()
        let item = Tickets(from_id: productData[indexPath.row].value(forKey: "from_id") as! String, to_id: productData[indexPath.row].value(forKey: "to_id") as! String, date: productData[indexPath.row].value(forKey: "date") as! String, price: productData[indexPath.row].value(forKey: "price") as! String, time_go: productData[indexPath.row].value(forKey: "time_go") as! String, time_arrive: productData[indexPath.row].value(forKey: "time_arrive") as! String, id: productData[indexPath.row].value(forKey: "id") as! String, from_short: productData[indexPath.row].value(forKey: "from_short") as! String, to_short: productData[indexPath.row].value(forKey: "to_short") as! String)
        vc.item = item
        navigationController?.navigationBar.tintColor = .mainTextColor
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func clearFavor(){
        coreManager.deleteAllData()
        tableView.reloadData()
    }
}
