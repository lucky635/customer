//
//  CheckInVC.swift
//  Customer
//
//  Created by Lucky on 30/08/19.
//  Copyright © 2019 Lucky. All rights reserved.
//

import UIKit

class CheckInVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
  //MARK:- Variables and outlets
    @IBOutlet weak var tableView: UITableView!
    var firstName:String = "n/a"
    var lastName:String = "n/a"
    var emailId:String = "n/a"
    var phoneNumber:String = "n/a"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
     //MARK:- Tableview delegedate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"CheckInCell") as! CheckInCell
        cell.textField.tag = indexPath.row + 100
        cell.textField.delegate = self
        if indexPath.row == 0 {
            cell.showTitle.text = "First Name"
            cell.textField.placeholder = "enter first name"
            
        }
        if indexPath.row == 1 {
            cell.showTitle.text = "Last Name"
            cell.textField.placeholder = "enter last name"
        }
        if indexPath.row == 2 {
            cell.showTitle.text = "Email Id"
            cell.textField.placeholder = "enter email"
        }
        if indexPath.row == 3 {
            cell.showTitle.text = "Phone Number"
            cell.textField.placeholder = "enter phone number"
            cell.textField.keyboardType = .numberPad
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- textField delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 100 {
            firstName = textField.text!
        }
        if textField.tag == 101 {
            lastName = textField.text!
        }

        if textField.tag == 102 {
            emailId = textField.text!
        }

        if textField.tag == 103 {
            phoneNumber = String(textField.text!)
        }

        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 100 {
            return textField.text!.count < 20 || string == ""
        }
        if textField.tag == 101 {
            return textField.text!.count < 20 || string == ""
        }
        if textField.tag == 102 {
            return textField.text!.count < 64 || string == ""
        }
        if textField.tag == 103 {
            return textField.text!.count < 10 || string == ""
        }
       
        return textField.text!.count < 50 || string == ""
    }
    //MARK:- back Button
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated:true)
    }
    
    //MARK:- Save Button
    @IBAction func saveData(_ sender: UIButton) {
        if firstName ==  "n/a" || firstName.isEmpty {
            showAlert(viewController:self, title:"Oops!", message:"Please enter valid First Name")
            
        }else if lastName == "n/a" || lastName.isEmpty{
            showAlert(viewController:self, title:"Oops!", message:"Please enter valid Last Name")
            
        }else if emailId == "n/a" || emailId.isEmpty  {
            showAlert(viewController:self, title:"Oops!", message:"Please enter valid Email Id")
            
        }else if !isValidEmailAddress(emailAddressString:emailId){
            showAlert(viewController:self, title:"Oops!", message:"Please enter valid Email Id")
        }
        else if phoneNumber == "n/a" || phoneNumber.isEmpty  {
            showAlert(viewController:self, title:"Oops!", message:"Please enter valid Phone Number")
            
        }else if phoneNumber.count < 10{
            showAlert(viewController:self, title:"Oops!", message:"Please enter valid Phone Number")
        }
        else {
            // save data
            if  !CoreDataOperations.shared.CheckUser(phoneNumber:phoneNumber){
                //store user data
                print(emailId,lastName,firstName,phoneNumber)
                let cData = Customer()
                cData.firstName = firstName
                cData.lastName = lastName
                cData.emailId = emailId
                cData.phoneNumber = phoneNumber
                CoreDataOperations.shared.StoreCustomerData(data:cData)
                self.navigationController?.popViewController(animated:true)
            }else {
                showAlert(viewController:self, title:"Oops!", message:"User Already exists.")
            }
            
            
        }
    }
    // MARK:- show alert to user
    func showAlert(viewController:UIViewController,title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- validate the email address
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            returnValue = false
        }
        
        return  returnValue
    }
}
