//
//  BasicInfoVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 03/09/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class BasicInfoVC: BaseViewController,OrderProccessingDelegate {
    func setData(arrData: [[String : String]]) {
        self.arrDataSec = arrData
    }
  
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var txtOrgName: UITextField!
  var arrDataSec: [[String: String]]  = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtName.text = self.appUserObject?.userName
            self.btnPrevious.isHidden = true
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if let navVCsCount = self.navigationController?.viewControllers.count {
            self.navigationController?.viewControllers.removeSubrange(Range(0..<navVCsCount-1))
        }

        print("viewDidAppearCall")
    }
   
    @IBAction func clickToNext(_ sender: Any) {
       
        if self.txtName.text?.count == 0{
            self.showToast(message: "Please enter your name")
        }else{
            self.txtOrgName.resignFirstResponder()
            self.txtName.resignFirstResponder()
            self.appUserObject?.lastName = self.txtName.text
            self.appUserObject?.countryCode = self.txtOrgName.text
            self.appUserObject?.saveToUserDefault()
            let vc = OrderProccessing(nibName: "OrderProccessing", bundle: nil)
                vc.arrAnswer = arrDataSec
                vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
     
    }
    
    @IBAction func clickToCancle(_ sender: Any) {
        _ = SweetAlert().showAlert("Cancel Evaluation?", subTitle: "Are you sure you want to cancel?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                // _ = SweetAlert().showAlert("Cancelled!", subTitle: "Your Order Processing is safe", style: AlertStyle.error)
            }
            else {
                // _ = SweetAlert().showAlert("Deleted!", subTitle: "Your Order Processing has been deleted!", style: AlertStyle.success)
                let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @IBAction func clickToPreviouse(_ sender: Any) {
       
    }
    
}
extension BasicInfoVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.setLeftPaddingPoints(15)
//        self.myTextField = textField
//        //  self.moveTextField(textField: textField, moveDistance: -10, up: true)
//    }
//
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        textField.inputAccessoryView = inputToolbar
//
//        return true
//    }
    

    
}
