//
//  CoreDataManager.swift
//  Tezkor Kassa
//
//  Created by Shaxzod Azamatjonov on 08/04/22.
//

import UIKit
import CoreData

class CoreDataManager{
    static let shared = CoreDataManager()
    
    func addFav(product: Tickets, compilation: @escaping (Result<Bool,Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "Appdelegate not found", code: 404)))
            return
        }
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Ticket", in: context)
        let ticketObject = NSManagedObject(entity: entity!, insertInto: context)
        ticketObject.setValue(product.from_id, forKey: "from_id")
        ticketObject.setValue(product.to_id, forKey: "to_id")
        ticketObject.setValue(product.date, forKey: "date")
        ticketObject.setValue(product.price, forKey: "price")
        ticketObject.setValue(product.time_go, forKey: "time_go")
        ticketObject.setValue(product.time_arrive, forKey: "time_arrive")
        ticketObject.setValue(product.id, forKey: "id")
        ticketObject.setValue(product.from_short, forKey: "from_short")
        ticketObject.setValue(product.to_short, forKey: "to_short")
        do {
            try context.save()
            compilation(.success(true))
        }catch{
            compilation(.failure(error))
        }
    }
    
    func fetchFromFav(compilation: @escaping (Result<[NSManagedObject], Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "Appdelegate not found", code: 404)))
            return
        }
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Ticket")
        do{
            let product = try context.fetch(request)
            compilation(.success(product))
        }catch let err{
            compilation(.failure(err))
        }
    }
    func deleteObjejct(object: Ticket) -> Bool {
         let delegate = UIApplication.shared.delegate as! AppDelegate
        let ctx = delegate.persistentContainer.viewContext
        do {
            try ctx.delete(object)
            print("Uje udalit !")
        }catch let err{
            print(err)
            return false
        }
        
        return true
    }
    func deleteAllData(){

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
}

