//
//  CustomerData.swift
//  Customer
//
//  Created by Lucky on 30/08/19.
//  Copyright © 2019 Lucky. All rights reserved.
//

import Foundation
class Customer{
    static var shared = Customer()
    var firstName:String!
    var lastName:String!
    var emailId:String!
    var phoneNumber:String!
    func getCutomerData(completion: @escaping ([Customer]?) -> ())
    {
        let head:[String:String] = ["Accept" :"application/json",
                                    "Content-Type":"application/json"]
        var request = URLRequest(url: URL(string: "https://api.birdeye.com/resources/v1/customer/all?businessId=152689127922748&api_key=5qadXfy8F2qCd2froDoKu1MsYvuXgtco")!)
        request.allHTTPHeaderFields = head
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with:request) { data, response, error in
            if !data!.isEmpty{
                do {
                    let d = try JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
                    var dataList = [Customer]()
                    for c in d {
                        let cData = Customer()
                        if let fName = c["firstName"] {
                            if let f = fName as? String {
                                cData.firstName = (f)
                            }else {
                                cData.firstName = "n/a"
                            }
                        }
                        if let lName = c["lastName"] {
                            if let l = lName as? String {
                                cData.lastName = (l)
                            }else {
                                cData.lastName = "n/a"
                            }
                        }
                        if let email = c["emailId"] {
                            if let e = email as? String {
                                cData.emailId = (e)
                            }
                            else {
                                cData.emailId = "n/a"
                            }
                        }
                        if let phone = c["phone"] {
                            if let ph = phone as? String {
                                cData.phoneNumber = (ph)
                            }else {
                                cData.phoneNumber = "n/a"
                            }
                        }
                        DispatchQueue.main.async {
                            CoreDataOperations.shared.StoreCustomerData(data:cData)
                        }
                        
                        dataList.append(cData)
                    }
                    completion(dataList)
                }catch{
                    completion(nil)
                }
        }
            else {
                 completion(nil)
            }

}.resume()
}
}


