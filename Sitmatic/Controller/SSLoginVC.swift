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
    
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.imgButtonLogin.image = UIImage(named: "login.png")
        
    }

    override func viewWillAppear(_ animated: Bool) {
//         print( btnLogin.frame.size.width - (imgButtonLogin.frame.size.width + 15.0))
//
//        btnLogin.imageEdgeInsets = UIEdgeInsetsMake(15, btnLogin.frame.size.width - (imgButtonLogin.frame.size.width + 15.0), 0.0, 0.0);
//        btnLogin.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, imgButtonLogin.frame.size.width);
        
        UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.synchronize()
    }
    
    override func viewDidLayoutSubviews() {
        self.txtEmail.layer.masksToBounds = true;
        self.txtEmail.layer.cornerRadius = 20.0
        self.txtPassword.layer.masksToBounds = true;
        self.txtPassword.layer.cornerRadius = 20.0
        self.btnLogin.layer.masksToBounds = true;
        self.btnLogin.layer.cornerRadius = 20.0
        self.btnLogin.layer.borderWidth = 1.0
        self.btnLogin.layer.borderColor = UIColor.white.cgColor
       
       
    }
 
    @IBAction func clickToLogin(_ sender: Any) {
        let strname = self.txtEmail.text
        let isValid = self.isValidEmail(testStr: strname!)
        if self.txtEmail.text?.count == 0{
            self.showToast(message: "Please enter email address")
        }else if self.txtPassword.text?.count == 0 {
            
            self.showToast(message: "Please enter password address")
            
        }else if isValid == false{
            self.showToast(message: "Please enter valid email address")
        }else{
           
            callLoginApi()
        }
        
        
        
   
    }
    
    @IBAction func clickToForgot(_ sender: Any) {
        let vc = SForgotPass(nibName: "SForgotPass", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func clickToSignUp(_ sender: Any) {
        let vc = SSignupVC(nibName: "SSignupVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func callLoginApi(){
        let dic = [
                   "email" : self.txtEmail.text,
                   "password" : self.txtPassword.text,
                   ]
        
        SVProgressHUD.show()
        
        ServiceClass().getLoginDetails(strUrl: "login", param: dic as! [String : String]) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                
              
                SVProgressHUD.dismiss()
            }else{
              
                
                if dicdata["status"] as! String == "Ok"{
                      print(dicdata)
                    
                    if let user = dicdata["successData"] as? [String : Any] {
                        self.appUserObject = AppUserObject.instance(from: dicdata)
                        self.appUserObject?.userName = user["name"] as! String
                        self.appUserObject?.access_token = user["token"] as! String
                        self.appUserObject?.email = user["email"] as! String
                        self.appUserObject?.mobile = user["mobile"] as! String
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        UserDefaults.standard.synchronize()
                        self.appUserObject?.saveToUserDefault()
                        let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
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
