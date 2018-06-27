//
//  SForgotPass.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

class SForgotPass: BaseViewController {
    @IBOutlet var ViewPassword: UIView!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    var strEmail: String!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtVerification: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        self.txtEmail.layer.masksToBounds = true;
        self.txtEmail.layer.cornerRadius = 20.0
        
        self.txtVerification.layer.masksToBounds = true;
        self.txtVerification.layer.cornerRadius = 20.0
        
        
        self.txtPassword.layer.masksToBounds = true;
        self.txtPassword.layer.cornerRadius = 20.0
        
        self.txtConfirmPass.layer.masksToBounds = true;
        self.txtConfirmPass.layer.cornerRadius = 20.0

        self.btnCheck.layer.masksToBounds = true;
        self.btnCheck.layer.cornerRadius = 20.0
        self.btnCheck.layer.borderWidth = 1.0
        self.btnCheck.layer.borderColor = UIColor.white.cgColor
        
        self.btnSubmit.layer.masksToBounds = true;
        self.btnSubmit.layer.cornerRadius = 20.0
        self.btnSubmit.layer.borderWidth = 1.0
        self.btnSubmit.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    @IBAction func clickToDone(_ sender: Any) {
        
        let strname = self.txtEmail.text
        let isValid = self.isValidEmail(testStr: strname!)
      
        if self.txtEmail.text?.count == 0 {
            self.showToast(message: "Please enter email Address")
        }  else if isValid == false{
            self.showToast(message: "Please enter valid email address")
        }
        else{
            callLoginApi()
        }
        
        
    }
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callLoginApi(){
        let dic = ["email":self.txtEmail.text]

        
        
        SVProgressHUD.show()
        
        ServiceClass().verifieEmail(strUrl:"validateemail", param: dic as! [String : String] ) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                
                
                SVProgressHUD.dismiss()
            }else{
                
                
                if dicdata["status"] as! String == "Ok"{
                    print(dicdata)
                    self.strEmail = self.txtEmail.text
                    self.ViewPassword.frame = self.view.bounds
                    self.view.addSubview(self.ViewPassword)
                    
                }
                else{
                    
                    print(dicdata)
                    
                    self.showToast(message: dicdata["errorData"] as! String)
                }
                
                
                
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    @IBAction func clickToBtnSubmit(_ sender: Any) {
        
        let firstPassword = self.txtPassword.text
        let secondPassword = self.txtConfirmPass.text
        
        if self.txtPassword.text?.count == 0{
            self.showToast(message: "Please enter your password ")
        }
        else if self.txtConfirmPass.text?.count == 0{
            self.showToast(message: "Please enter your confirm password ")
        }else if  (firstPassword!.isEqualToString(find: secondPassword!)) == false {
            self.showToast(message: "Please enter same password ")
        }else{
            
            callPassSave()
        }
        
    }
    
    
    
    func callPassSave(){
        let dic = ["email": self.strEmail,
                   "password":self.txtPassword.text,
                   "reset_token":self.txtVerification.text]
        
        
        
        SVProgressHUD.show()
        
        ServiceClass().verifieEmail(strUrl:"updatepassword", param: dic as! [String : String] ) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                
                
                SVProgressHUD.dismiss()
            }else{
                
                
                if dicdata["status"] as! String == "Ok"{
                    print(dicdata)
                    _ = SweetAlert().showAlert("Password Changed Successfully", subTitle: "Click here to login ", style: AlertStyle.success, buttonTitle:"", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Ok", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                        if isOtherButton == true {
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                        else {
                            
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
                else{
                    
                    print(dicdata)
                    
                    self.showToast(message: dicdata["errorData"] as! String)
                }
                
                
                
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
}

extension SForgotPass: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(10)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}

