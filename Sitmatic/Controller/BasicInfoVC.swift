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
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgConstraintTopHeight: NSLayoutConstraint!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var txtOrgName: UITextField!
  var arrDataSec: [[String: String]]  = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtName.text = self.appUserObject?.userName
        self.btnPrevious.isHidden = false
        self.setTopView(self.viewTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if let navVCsCount = self.navigationController?.viewControllers.count {
            self.navigationController?.viewControllers.removeSubrange(Range(0..<navVCsCount-1))
        }

        print("viewDidAppearCall")
        
        
    }
    
    @objc func rightButtonClicked(_ sender: Any) {
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
   
    override func viewDidLayoutSubviews() {
        UIView().setShadow(self.viewContainer)
        UIView().setShadowImg(self.imgBanner)
        self.imgBanner.layer.cornerRadius = 5.0
        self.imgBanner.clipsToBounds = true
        if device.diagonal == 4{
            
            self.imgConstraintTopHeight.constant = 25.0
        }else   if device.diagonal == 4.7{
            
            self.imgConstraintTopHeight.constant = 30.0
        }else   if device.diagonal == 5.5{
            
            self.imgConstraintTopHeight.constant = 35.0
        }
        else {
            // self.viewLableHeight.constant = 180.0
            self.imgConstraintTopHeight.constant = 40.0
            
        }
        
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(15)
    
          self.moveTextField(textField: textField, moveDistance: -150, up: true)
    }


 
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, moveDistance: -150, up: false)
    }

    
}
