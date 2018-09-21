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



class SProfileVC: BaseViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate ,UITextViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var txtZip: UITextField!
    
    var imageUser = UIImage()
    var objeHome = SHomeVC()
    
    @IBOutlet weak var lblUserName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnLogOut.layer.cornerRadius = 5.0;
        self.viewProfile.layer.cornerRadius = 5.0;
        self.lblUserName.text = self.appUserObject?.userName
        self.lblUserEmail.text = self.appUserObject?.email
        let strnumber = self.appUserObject?.mobile
         let strAddress = self.appUserObject?.address
        self.txtMobile.text = " Mobile :  \(strnumber!)"
        self.txtZip.text =  self.appUserObject?.countryCode
        
        self.txtMobile.isEnabled = false
        self.txtAddress.isEditable = false
        self.txtZip.isEnabled = false
        
        imgView.layer.borderWidth = 1
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1).cgColor
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.clipsToBounds = true
        self.btnEdit.isHidden = true
        

        self.btnPhoto.isEnabled = false

        self.btnLogOut.isEnabled = true
        
        if    (self.appUserObject?.userImageUrl)! == "" {
                self.imgView.image = UIImage(named: "nouser.png")
                self.imageUser = UIImage(named: "nouser.png")!
            self.btnEdit.isHidden = false
        }
        else{
            imgView.kf.indicatorType = .activity
           
            let url = URL(string: (self.appUserObject?.userImageUrl)!)
            imgView.kf.setImage(with: url)
           
            KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                self.imageUser = image!
                self.btnEdit.isHidden = false
            })
           
        }
        
        if    (self.appUserObject?.address)! == "" {
             self.txtAddress.text = "Please select your address"
        }
        else{
                self.txtAddress.text = strAddress!
        }
        
 

       

        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func clickToEdit(_ sender: Any) {
        
        if btnEdit.isSelected {
           
            
            if self.txtAddress.text == "" {
               self.showToastForQue(message: "Please select your address", y: 75)
                 self.btnEdit.setButtonImage("ic_check_white")
                 self.btnLogOut.isHidden = true
            }else{
                self.btnEdit.setButtonImage("edit.png")
                self.txtAddress.isEditable = false
                self.btnPhoto.isEnabled = false
                 self.txtZip.isEnabled = false
                self.btnEdit.isSelected = false
                 callServiceEditProfile()
                
            }
            
            
           
        }else{
            self.txtAddress.isEditable = true
            self.btnPhoto.isEnabled = true
            self.btnEdit.setButtonImage("ic_check_white")
            self.btnLogOut.isHidden = true
            self.btnEdit.isSelected = true
             self.txtZip.isEnabled = true
            
        }
        
        
        
    }
    

    
    
    
    
    
    func callServiceEditProfile(){
        
        SVProgressHUD.show()
        
        var  strName = (self.appUserObject?.access_token)!
        strName = "updateprofile?token=\(strName)"
        
        let dic = ["id": (self.appUserObject?.userId)!,
                   "address": self.txtAddress.text,
                   "zipcode": self.txtZip.text] as [String : Any]
        

        
        
        
        ServiceClass().profileUpdate(strUrl: strName, param: dic as! [String : String], img: imageUser, completion: { err, dicdata in
            
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
                self.btnLogOut.isHidden = false
                
            }
            else{
                
                print(dicdata)
                
                self.showToastForQue(message: dicdata["errorData"] as! String, y: 75)
                 SVProgressHUD.dismiss()
            }
            
            
        })
    }
    
    
    
    
    
    
    
    @IBAction func clickToBack(_ sender: Any) {
      
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToLogOut(_ sender: Any) {
        callLogOutApi()
    }
    
    
    @IBAction func clickToSelectImg(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let actionsheet = UIAlertController(title: "", message: "Select a Source", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else
            {
                //print("Camera is Not Available")
                
                ECSAlert().showAlert(message: "Camera Not Available", controller: self)
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
        self.imageUser = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }

    
    
    
    
    
    func callLogOutApi(){
        let dic = ["":""]
        let strToken = self.appUserObject?.access_token
        let srtUrl = "logout?token=\(strToken!)"
        self.btnLogOut.isEnabled = false
        
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
                    
                    self.showToastForQue(message: dicdata["errorData"] as! String, y: 75)
                    self.btnLogOut.isEnabled = true
                }
                
                
                
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      
        let strNew : NSString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }

        
        return true
    }
    

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if textField == self.txtZip {
            return textField.text!.count < 5 || string == ""
        }
        return true
    }

    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Please select your address")
        {
           textView.text = ""
            textView.textColor = .black
        }else if (textView.text == "")
        {
           
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Please select your address"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
}


