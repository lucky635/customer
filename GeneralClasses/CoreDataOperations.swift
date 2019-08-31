//
//  CoreDataOperations.swift
//  Customer
//
//  Created by Lucky on 30/08/19.
//  Copyright © 2019 Lucky. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataOperations{
    static var shared = CoreDataOperations()
    private var context:NSManagedObjectContext!
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        context = appDelegate.persistentContainer.viewContext
    }
    //MARK:- Store New Customer Data and Update the existing Customer Data
    func StoreCustomerData(data:Customer){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"CustomerData")
        do {
            request.predicate = NSPredicate(format:"phoneNumber == %@",data.phoneNumber)
            let check = try context.fetch(request)
            if (check.count > 0) {
                // device contains in core data
                for d in check as! [NSManagedObject] {
                    d.setValue(data.firstName, forKey: "firstName")
                    d.setValue(data.lastName,forKey: "lastName")
                    d.setValue(data.phoneNumber, forKey: "phoneNumber")
                    d.setValue(data.emailId, forKey: "email")
                   
                }
                saveData()
            }else {
                let entity = NSEntityDescription.entity(forEntityName:"CustomerData", in: context)
                let newCustomer = NSManagedObject(entity: entity!, insertInto: context)
                newCustomer.setValue(data.firstName, forKey: "firstName")
                newCustomer.setValue(data.lastName,forKey: "lastName")
                newCustomer.setValue(data.phoneNumber, forKey: "phoneNumber")
                newCustomer.setValue(data.emailId, forKey: "email")
               
            }
        } catch  {
            
        }
        saveData()
    }
    //MARK:- Get Customer Data From Core Data
    func GetCustomerData()-> [Customer] {
        var cList = [Customer]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"CustomerData")
        request.returnsObjectsAsFaults = false
        // thing search if search true then return
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let cdata = Customer()
                cdata.emailId = (data.value(forKey:"email") as! String)
                cdata.firstName = (data.value(forKey:"firstName") as! String)
                cdata.lastName = (data.value(forKey:"lastName") as! String)
                cdata.phoneNumber = (data.value(forKey:"phoneNumber") as! String)
                cList.append(cdata)
            }
        } catch {
            
        }
        return cList
    }
    // MARK:- check whether user already present or not
    func CheckUser(phoneNumber:String)->Bool{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"CustomerData")
        do {
            request.predicate = NSPredicate(format:"phoneNumber == %@",phoneNumber)
            let check = try context.fetch(request)
            if (check.count > 0) {
                
                return true
            }
        } catch  {
            
        }
        
        return false
    }
    //MARK:- Delete Customer Data From Core Data
    func DeleteCustomerData(phoneNumber:String){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"CustomerData")
        request.returnsObjectsAsFaults = false
        do {
            request.predicate = NSPredicate(format:"phoneNumber == %@",phoneNumber)
            let result = try context.fetch(request)
            if (result.count > 0) {
                for data in result as! [NSManagedObject] {
                    context.delete(data)
                }
            }
        } catch {
            
            
        }
        saveData()
    }
    
    // save data
    func saveData(){
        
        do {
            try context.save()
        } catch {
            
        }
    }
}
