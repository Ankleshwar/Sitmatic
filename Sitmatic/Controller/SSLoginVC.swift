//
//  SSLoginVC.swift
//  Sitmatic
//
//  Created by Ankleshwar on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class SSLoginVC: BaseViewController {
    @IBOutlet weak var imgButtonLogin: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgButtonLogin.image = UIImage(named: "login.png")
        
    }

    override func viewWillAppear(_ animated: Bool) {
//         print( btnLogin.frame.size.width - (imgButtonLogin.frame.size.width + 15.0))
//
//        btnLogin.imageEdgeInsets = UIEdgeInsetsMake(15, btnLogin.frame.size.width - (imgButtonLogin.frame.size.width + 15.0), 0.0, 0.0);
//        btnLogin.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, imgButtonLogin.frame.size.width);
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
    

    @IBAction func clickToSignUp(_ sender: Any) {
        let vc = SSignupVC(nibName: "SSignupVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
