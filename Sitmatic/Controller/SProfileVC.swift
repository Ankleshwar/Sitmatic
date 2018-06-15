//
//  SProfileVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher



class SProfileVC: BaseViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnPhoto: UIButton!
    var image = UIImage()
    @IBOutlet weak var lblUserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnLogOut.layer.cornerRadius = 5.0;
        self.viewProfile.layer.cornerRadius = 5.0;
        self.lblUserName.text = self.appUserObject?.userName
        self.lblUserEmail.text = self.appUserObject?.email
        let strname = self.appUserObject?.mobile
        self.txtMobile.text = "Mobile : \(strname!)"
        self.txtAddress.text = self.appUserObject?.address
        
        self.txtMobile.isEnabled = false
        self.txtAddress.isEnabled = false
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = (imgView.frame.size.height)/2
        self.btnPhoto.isEnabled = false
        
        if    (self.appUserObject?.userImageUrl)! == "" {
            self.imgView.image = UIImage(named: "nouser.png")
        }
        else{
            let url = URL(string: (self.appUserObject?.userImageUrl)!)
            imgView.kf.setImage(with: url)
        }
        
    }
    @IBAction func clickToEdit(_ sender: Any) {
        
        if btnEdit.isSelected {
            self.txtAddress.isEnabled = false
            self.btnPhoto.isEnabled = false
             self.btnEdit.setButtonImage("edit.png")
            self.btnEdit.isSelected = false
            callServiceEditProfile()
        }else{
            self.txtAddress.isEnabled = true
            self.btnPhoto.isEnabled = true
            self.btnEdit.setButtonImage("ic_check_white")
            self.btnEdit.isSelected = true
            
        }
        
        
        
    }
    

    
    
    
    
    
    func callServiceEditProfile(){
        
        SVProgressHUD.show()
        
        var  strName = (self.appUserObject?.access_token)!
        strName = "updateprofile?token=\(strName)"
        
        let dic = ["id": (self.appUserObject?.userId)!,
                   "address": self.txtAddress.text] as [String : Any]
        
        ServiceClass().profileUpdate(strUrl: strName, param: dic as! [String : String], img: image, completion: { err, dicdata in
            
            if dicdata["status"] as! String == "Ok"{
                print(dicdata)
               let succcessData = dicdata["successData"] as! [String : Any]
              //  self.appUserObject = AppUserObject.instance(from: succcessData)
                self.appUserObject?.userImageUrl = succcessData["image"] as! String
                self.appUserObject?.address = succcessData["address"] as! String
                self.appUserObject?.mobile = succcessData["mobile"] as! String
                 self.appUserObject?.userName = succcessData["name"] as! String
                self.appUserObject?.email = succcessData["email"] as! String
                //self.appUserObject?.access_token = strName
                let id = succcessData["id"] as! Int
                //self.appUserObject?.userId = String(id)
                self.appUserObject?.saveToUserDefault()
                let url = URL(string: (self.appUserObject?.userImageUrl)!)
                let imgholder = UIImageView()
                imgholder.kf.setImage(with: url)
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
                print(dicdata)
                
                self.showToast(message: dicdata["errorData"] as! String)
                 SVProgressHUD.dismiss()
            }
            
            
        })
    }
    
    
    
    
    
    
    
    @IBAction func clickToBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToLogOut(_ sender: Any) {
        callLoginApi()
    }
    
    
    @IBAction func clickToSelectImg(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose A Sourece", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else
            {
                print("Camera is Not Available")
                
                ECSAlert().showAlert(message: "Camera is Not Available", controller: self)
            }
            
            
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imgView.image = image
        self.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
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


