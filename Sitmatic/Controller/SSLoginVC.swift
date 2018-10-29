//
//  SSLoginVC.swift
//  Sitmatic
//
//  Created by Ankleshwar on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

class SSLoginVC: BaseViewController {
   // @IBOutlet weak var imgButtonLogin: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var lblShowError: UILabel!
    
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {

        
        UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.synchronize()
        self.txtEmail.text = ""
        self.txtPassword.text = ""
        self.lblShowError.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
//        self.txtEmail.layer.masksToBounds = true;
//        self.txtEmail.layer.cornerRadius = self.txtEmail.frame.height / 2.0
//        self.txtPassword.layer.masksToBounds = true;
//        self.txtPassword.layer.cornerRadius = self.txtPassword.frame.height / 2.0
        self.btnLogin.layer.masksToBounds = true;
        self.btnLogin.layer.cornerRadius = self.btnLogin.frame.height / 2.0
        self.btnLogin.layer.borderWidth = 1.0
        self.btnLogin.layer.borderColor = UIColor.white.cgColor
       
       
    }
 
    @IBAction func clickToLogin(_ sender: Any) {
        let strname = self.txtEmail.text
        let isValid = self.isValidEmail(testStr: strname!)
        if self.txtEmail.text?.count == 0{
            self.showToast(message: "Please enter Email address")
        }else if self.txtPassword.text?.count == 0 {
            
            self.showToast(message: "Please enter password ")
            
        }else if isValid == false{
            self.showToast(message: "Please enter valid Email address")
        }else{
             self.view.isUserInteractionEnabled = false
            callLoginApi()
        }
        
        
        
   
    }
    
    @IBAction func clickToForgot(_ sender: Any) {
        
        if (sender as AnyObject).currentTitle == "Resend Verification Link" {
            callResendVerificationApi()
            
        }else{
            let vc = SForgotPass(nibName: "SForgotPass", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       
        
    }
    
    @IBAction func clickToSignUp(_ sender: Any) {
        let vc = SSignupVC(nibName: "SSignupVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func callLoginApi(){
         self.txtPassword.resignFirstResponder()
        let dic = [
                   "email" : self.txtEmail.text,
                   "password" : self.txtPassword.text,
                   ]
        
        SVProgressHUD.show()
        
        ServiceClass().getLoginDetails(strUrl: "login", param: dic as! [String : String]) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                  self.view.isUserInteractionEnabled = true
              
                SVProgressHUD.dismiss()
            }else{
               self.view.isUserInteractionEnabled = true
                
                if dicdata["status"] as! String == "Ok"{
                      print(dicdata)
                    
                    if let user = dicdata["successData"] as? [String : Any] {
                        self.appUserObject = AppUserObject.instance(from: dicdata)
                        self.appUserObject?.userName = user["name"] as! String
                        self.appUserObject?.access_token = user["token"] as! String
                        self.appUserObject?.email = user["email"] as! String
                        self.appUserObject?.mobile = user["mobile"] as! String
                        self.appUserObject?.userImageUrl = user["image"] as! String
                        self.appUserObject?.pincode = user["zipcode"] as! String
                        let id = user["id"] as! Int
                        self.appUserObject?.address = user["address"] as! String
                        self.appUserObject?.userId = String(id)
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        UserDefaults.standard.synchronize()
                        self.appUserObject?.saveToUserDefault()
                        let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                
                }
                else{
                    
                      print(dicdata)
                    
                    let strError = dicdata["errorData"] as! String
                    if strError == "Your account is not verified!!!"{
                        self.showToast(message: dicdata["errorData"] as! String)
                        self.btnForgot.setButtonTitle("Resend Verification Link")
                        self.btnForgot.setTitleColor(UIColor.red, for: .normal)
                        self.lblShowError.isHidden = false
                        self.lblShowError.text = dicdata["errorData"] as? String
                    }else{
                        self.showToast(message: dicdata["errorData"] as! String)
                    }
                    
                  
                    
                }
                
                
                
              
                }
                
                SVProgressHUD.dismiss()
            }
            
        
    }
    
    
    
    func callResendVerificationApi(){
        let dic = [
            "email" : self.txtEmail.text,
            
            ]
        
        SVProgressHUD.show()
        
        ServiceClass().getLoginDetails(strUrl: "resendemailverificationlink", param: dic as! [String : String]) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                
                
                SVProgressHUD.dismiss()
            }else{
                
                
                if dicdata["status"] as! String == "Ok"{
                    print(dicdata)
                    
                    self.btnForgot.setButtonTitle("Forgot Password?")
                     self.lblShowError.isHidden = true
                    self.btnForgot.setTitleColor(UIColor.white, for: .normal)
                    self.showToast(message: dicdata["successData"] as! String)
                    
                }
                else{
                    
                    print(dicdata)
                    
                    let strError = dicdata["errorData"] as! String
                    if strError == "Your account is not verified!!!"{
                        self.showToast(message: dicdata["errorData"] as! String)
                        self.btnForgot.setButtonTitle("Resend Verification Link")
                        self.btnForgot.setTitleColor(UIColor.red, for: .normal)
                    }else{
                        self.showToast(message: dicdata["errorData"] as! String)
                    }
                    
                    
                    
                }
                
                
                
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    
    

}


extension SSLoginVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(20)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
}
