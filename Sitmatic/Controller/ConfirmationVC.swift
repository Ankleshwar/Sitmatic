//
//  AddressVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 10/07/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class ConfirmationVC: BaseViewController,UITextViewDelegate {

 
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtAddress.isEditable = false
  
        self.lblEmail.text = (self.appUserObject?.email)!
     
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "Roboto-Light", size: 19) ?? "", NSAttributedStringKey.foregroundColor :#colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)] as [NSAttributedStringKey : Any]
        
        let attrs2 = [NSAttributedStringKey.font : UIFont(name: "Roboto-Bold", size: 22) ?? "", NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.2274509804, green: 0.6862745098, blue: 0.8980392157, alpha: 1)] as [NSAttributedStringKey : Any]
        
        let attributedString1 = NSMutableAttributedString(string:"Your ideal chair model is ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"QM22SE", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.lblModel.attributedText = attributedString1
        self.lblPrice.text = "Total Price:" + " " + "$" + "1120"
        
        if    (self.appUserObject?.address)! == "" {
            self.txtAddress.text = "Please select your address"
        }
        else{
            self.txtAddress.text = (self.appUserObject?.address)!
        }
        
        
    }

    
    @IBAction func clickToDone(_ sender: Any) {
    }
    
    @IBAction func clickToCancle(_ sender: Any) {
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //let strNew : NSString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        
        return true
    }
    
    @IBAction func clickToEdit(_ sender: Any) {
        if btnEdit.isSelected {
            
            
            if self.txtAddress.text == "" {
                self.showToastForQue(message: "Please select your address", y: 75)
                self.btnEdit.setButtonImage("ic_check_white")
                
            }else{
              
                self.btnEdit.setButtonImage("editblack.png")
                self.txtAddress.isEditable = false
               
                
                self.btnEdit.isSelected = false
               
                
            }
            
            
            
        }else{
            self.txtAddress.isEditable = true
          
            self.btnEdit.setButtonImage("ic_check_white")
            
            self.btnEdit.isSelected = true
            
        }
    }
    
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
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
    
}

