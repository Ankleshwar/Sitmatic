//
//  SProfileVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

class SProfileVC: BaseViewController {
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var lblUserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnLogOut.layer.cornerRadius = 5.0;
          self.viewProfile.layer.cornerRadius = 5.0;
        self.lblUserName.text = self.appUserObject?.userName
        self.lblUserEmail.text = self.appUserObject?.email
        let strname = self.appUserObject?.mobile
        self.txtMobile.text = "Mobile : \(strname!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToLogOut(_ sender: Any) {
        callLoginApi()
    }
    
    
    func callLoginApi(){
        let dic = ["":""]
        let strToken = self.appUserObject?.access_token
        let srtUrl = "logout?token=\(strToken!)"
        
        
        SVProgressHUD.show()
        
        ServiceClass().logoutUser(strUrl: srtUrl, param: dic ) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                
                
                SVProgressHUD.dismiss()
            }else{
                
                
                if dicdata["status"] as! String == "Ok"{
                    print(dicdata)
                    UserDefaults.standard.set(false, forKey: "isLogin")
                    UserDefaults.standard.synchronize()
                    let delegate =  UIApplication.shared.delegate as! AppDelegate
                    delegate.setRootController()
                    
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


