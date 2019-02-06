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
        @IBOutlet weak var lblErrorHeight: NSLayoutConstraint!
        
        @IBOutlet weak var txtEmail: UITextField!
        @IBOutlet weak var txtPassword: UITextField!
        @IBOutlet weak var btnForgot: UIButton!
        @IBOutlet weak var lblShowError: UILabel!
        @IBOutlet weak var viewContainer: UIView!
        
        @IBOutlet weak var btnLogin: UIButton!
        override func viewDidLoad() {
            super.viewDidLoad()
            self.hideKeyboardWhenTappedAround()
            
        }

        override func viewWillAppear(_ animated: Bool) {

            
            UserDefaults.standard.set(false, forKey: "isLogin")
            UserDefaults.standard.synchronize()
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            self.lblShowError.isHidden = true
            txtEmail.setLeftPaddingPoints(7)
            txtPassword.setLeftPaddingPoints(7)
        }
        
        override func viewDidLayoutSubviews() {
             UIView().setShadow(self.viewContainer)

            self.btnLogin.layer.masksToBounds = true;
            self.btnLogin.layer.cornerRadius = self.btnLogin.frame.height / 2.0
            self.btnLogin.layer.borderWidth = 1.0
            self.btnLogin.layer.borderColor = UIColor.white.cgColor
           }
     
        @IBAction func clickToLogin(_ sender: Any) {
            let strname = self.txtEmail.text
            let isValid = self.isValidEmail(testStr: strname!)
            if self.txtEmail.text?.count == 0{
                self.showToastLocal(message: "Please enter your email address")
                self.textField(color: UIColor.red, txtxField:self.txtEmail )
            }else if self.txtPassword.text?.count == 0 {
                
                self.showToastLocal(message: "Please enter your password ")
                self.textField(color: UIColor.red, txtxField:self.txtPassword )
                
            }else if isValid == false{
                self.showToastLocal(message: "Please enter a valid email address")
                self.textField(color: UIColor.red, txtxField:self.txtEmail )
            }else{
                 self.view.isUserInteractionEnabled = false
                callLoginApi()
            }
       
        }

        fileprivate func textField(color:UIColor,txtxField:UITextField) {
            txtxField.layer.borderWidth = 0.7
            txtxField.layer.borderColor = color.cgColor

        }

        func showToastLocal(message : String) {


           self.lblShowError.isHidden = false
            self.lblErrorHeight.constant = 40
            self.lblShowError.numberOfLines = 0
            self.lblShowError.textColor = UIColor.red
            self.lblShowError.textAlignment = .center;
            self.lblShowError.font = UIFont(name: "Roboto", size: 16.0)
            self.lblShowError.text = message
            self.lblShowError.alpha = 1.0
            self.lblShowError.layer.cornerRadius = 10;
            self.lblShowError.clipsToBounds  =  true
            //self.view.addSubview(self.lblShowError)
            UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseOut, animations: {
                self.lblShowError.alpha = 0.0
            }, completion: {(isCompleted) in
                //self.lblShowError.removeFromSuperview()
                self.lblShowError.isHidden = true
                self.lblErrorHeight.constant = 0

            })
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
                            self.appUserObject?.userName = user["name"] as? String
                            self.appUserObject?.access_token = user["token"] as? String
                            self.appUserObject?.email = user["email"] as? String
                            self.appUserObject?.mobile = user["mobile"] as? String
                            self.appUserObject?.userImageUrl = user["image"] as? String
                            self.appUserObject?.pincode = user["zipcode"] as? String
                            let id = user["id"] as! Int
                            self.appUserObject?.address = user["address"] as? String
                            self.appUserObject?.userId = String(id)
                            UserDefaults.standard.set(true, forKey: "isLogin")
                            UserDefaults.standard.synchronize()
                            self.appUserObject?.saveToUserDefault()

                            let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                            self.navigationController?.pushViewController(vc, animated: true)


                        }
                    }
                    else{
                        let strError = dicdata["errorData"] as! String
                        if strError == "Your account is not verified!"{
                            self.showToastLocal(message: dicdata["errorData"] as! String)
                            self.btnForgot.setButtonTitle("Resend Verification Link")
                            self.btnForgot.setTitleColor(UIColor.black, for: .normal)
                            self.btnForgot.layer.masksToBounds = true;
                            self.btnForgot.titleLabel?.font =  UIFont(name: "Roboto Regular", size: 16)
                            self.btnForgot.layer.cornerRadius = self.btnLogin.frame.height / 2.0
                            self.btnForgot.layer.borderWidth = 1.0
                            self.btnForgot.layer.borderColor = UIColor.white.cgColor
                            self.btnForgot.backgroundColor = #colorLiteral(red: 0.7754912972, green: 0.9129186273, blue: 0.9814837575, alpha: 1)
                            //self.lblShowError.isHidden = false
                           // self.lblErrorHeight.constant = 30
                            //self.lblShowError.text = dicdata["errorData"] as? String
                        }else{
                            self.showToastLocal(message: dicdata["errorData"] as? String ?? "")
                             //self.lblShowError.text = dicdata["errorData"] as? String
                          //  self.showToastLocal(message: dicdata["errorData"] as! String)
                        }
                    }
                    }
                
                    SVProgressHUD.dismiss()
                }
        }
        //MARK: Resend Email Verification link
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
                        self.showToastLocal(message: dicdata["successData"] as! String)
                    }
                    else{
                        print(dicdata)
                        let strError = dicdata["errorData"] as! String
                        if strError == "Your account is not verified!!!"{
                            self.showToastLocal(message: dicdata["errorData"] as! String)
                            self.btnForgot.setButtonTitle("Resend Verification Link")
                            self.btnForgot.setTitleColor(UIColor.red, for: .normal)
                        }else{
                            self.showToastLocal(message: dicdata["errorData"] as! String)
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
       // self.textField(color: UIColor.black, txtxField:textField )
         self.textField(color:UIColor.black,txtxField:textField)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField(color:UIColor.black,txtxField:textField)
       
    }
    
}
