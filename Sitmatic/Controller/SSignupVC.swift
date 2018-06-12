//
//  SSLoginVC.swift
//  Sitmatic
//
//  Created by Ankleshwar on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class SSignupVC: BaseViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    

    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    //@IBOutlet weak var imgButtonLogin: UIImageView!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.imgButtonLogin.image = UIImage(named: "login.png")
        
    }

    override func viewWillAppear(_ animated: Bool) {
//         print( btnLogin.frame.size.width - (imgButtonLogin.frame.size.width + 15.0))
//
//        btnLogin.imageEdgeInsets = UIEdgeInsetsMake(15, btnLogin.frame.size.width - (imgButtonLogin.frame.size.width + 15.0), 0.0, 0.0);
//        btnLogin.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, imgButtonLogin.frame.size.width);
        
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
        let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}


extension SSignupVC: UITextFieldDelegate{
    
    
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
