//
//  SSLoginVC.swift
//  Sitmatic
//
//  Created by Ankleshwar on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

class SSignupVC: BaseViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    

    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    //@IBOutlet weak var imgButtonLogin: UIImageView!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.imgButtonLogin.image = UIImage(named: "login.png")
        
    }

    override func viewWillAppear(_ animated: Bool) {

        
         self.txtMobile.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
        setCorveTextField()
        
    }
    
    override func viewDidLayoutSubviews() {
  
    
       
       
    }
    
    
    func setCorveTextField(){
    
        
        self.txtName.layer.masksToBounds = true;
        self.txtName.layer.cornerRadius = 20.0
        
        self.txtMobile.layer.masksToBounds = true;
        self.txtMobile.layer.cornerRadius = 20.0
        
        self.txtConfirmPassword.layer.masksToBounds = true;
        self.txtConfirmPassword.layer.cornerRadius = 20.0
        
        self.txtEmail.layer.masksToBounds = true;
        self.txtEmail.layer.cornerRadius = 20.0
        self.txtPassword.layer.masksToBounds = true;
        self.txtPassword.layer.cornerRadius = 20.0
        self.btnSignup.layer.masksToBounds = true;
        self.btnSignup.layer.cornerRadius = 20.0
        self.btnSignup.layer.borderWidth = 1.0
        self.btnSignup.layer.borderColor = UIColor.white.cgColor
    }
    
    
    @IBAction func clickToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSignUp(_ sender: Any) {
        let strname = self.txtEmail.text
        let isValid = self.isValidEmail(testStr: strname!)
        
        let firstPassword = self.txtPassword.text
        let secondPassword = self.txtConfirmPassword.text

        if self.txtName.text?.count == 0 {
            self.showToast(message: "Please enter your name")
        }else if self.txtEmail.text?.count == 0{
             self.showToast(message: "Please enter your email address")
        }
        else if isValid == false{
            self.showToast(message: "Please enter valid email address")
        }else if self.txtPassword.text?.count == 0{
            self.showToast(message: "Please enter your password ")
        }
        else if self.txtConfirmPassword.text?.count == 0{
            self.showToast(message: "Please enter your confirm password ")
        }else if  (firstPassword!.isEqualToString(find: secondPassword!)) == false {
             self.showToast(message: "Password mismatch  ")
        }else{

            callSignUpApi()
        }
        
        //var str = Dictionary
        
    }
    

    
    
   func callSignUpApi(){
    
     self.txtConfirmPassword.resignFirstResponder()
    
    let dic = ["name": self.txtName.text,
               "email" : self.txtEmail.text,
               "password" : self.txtPassword.text,
               "mobile": self.txtMobile.text]
    
    SVProgressHUD.show()
    
    ServiceClass().signUpDetails(strUrl: "register", param: dic as! [String : String]) { error, dicdata in
        
        if error != nil{
            print(dicdata)
        
            let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            SVProgressHUD.dismiss()
        }else{
                print(dicdata)
            
            if dicdata["status"] as! String == "Ok"{
                _ = SweetAlert().showAlert("Registration Status", subTitle: "Please verify the email address and login again", style: AlertStyle.success, buttonTitle:"", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Ok", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                    else {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }else{
                let dicDataError = dicdata["errorData"] as? [String : Any]
                
                let arry: NSArray = dicDataError!["email"] as! NSArray
                let strName = arry[0] as! String
                print(strName)
                self.showToast(message: strName)
                
            }
            
      
   
            
            SVProgressHUD.dismiss()
        }
        
    }
}

}


extension SSignupVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(15)
      //  self.moveTextField(textField: textField, moveDistance: -10, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //self.moveTextField(textField: textField, moveDistance: -10, up: true)
        self.scrollView.scrollToBottom(animated: true)
       
    }
    
}
