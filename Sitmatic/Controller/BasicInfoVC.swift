//
//  BasicInfoVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 03/09/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import Kingfisher
import IQKeyboardManagerSwift

class BasicInfoVC: BaseViewController,OrderProccessingDelegate {
    func setData(arrData: [[String : String]]) {
        self.arrDataSec = arrData
    }
    @IBOutlet weak var scrollView: UIScrollView!
    var myTextField = UITextField()
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgConstraintTopHeight: NSLayoutConstraint!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var txtOrgName: UITextField!
  var arrDataSec: [[String: String]]  = Array()
    lazy var inputToolbar: UIToolbar = {
        var toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.inputToolbarDonePressed))
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)

        var nextButton  = UIBarButtonItem(image: UIImage(named: "previous.png"),  style: .plain, target: self, action: #selector(self.keyboardpreviousButton))
        nextButton.width = 50.0
        var previousButton  = UIBarButtonItem(image: UIImage(named: "next.png"), style: .plain, target: self, action: #selector(self.keyboardNextButton))

        toolbar.setItems([fixedSpaceButton, nextButton, fixedSpaceButton, previousButton, flexibleSpaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        return toolbar
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
         self.txtName.setLeftPaddingPoints(10)
        self.txtName.text = self.appUserObject?.userName
        //self.txtEmail.text = self.appUserObject?.email
        self.btnPrevious.isHidden = true
        textField(color:UIColor.black)
        self.setTopView(self.viewTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
        imgBanner.kf.indicatorType = .activity
        let urlbaner = URL(string: imgBaseUrl)
        imgBanner.kf.setImage(with: urlbaner)
    }
    fileprivate func textField(color:UIColor) {
        self.txtName.layer.borderWidth = 0.7
        self.txtName.layer.borderColor = color.cgColor
        self.txtOrgName.layer.borderWidth = 0.7
        self.txtOrgName.layer.borderColor = color.cgColor
        // self.txtField.layer.cornerRadius = 5.0
    }
    override func viewDidAppear(_ animated: Bool) {
        if let navVCsCount = self.navigationController?.viewControllers.count {
            self.navigationController?.viewControllers.removeSubrange(Range(0..<navVCsCount-1))
        }

        print("viewDidAppearCall")
        

    }

  //  MARK: Textfield Next and Previous Method.

    @objc func inputToolbarDonePressed(){
        //self.scrollView.scrollsToTop = true
        self.txtName.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtOrgName.resignFirstResponder()
        self.txtLocation.resignFirstResponder()

    }
    @objc func keyboardNextButton(){

        if myTextField == txtName {
            self.txtEmail.becomeFirstResponder()
        }else if myTextField == txtEmail {
            self.txtOrgName.becomeFirstResponder()
        }else if myTextField == txtOrgName {
            self.txtLocation.becomeFirstResponder()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
        self.txtName.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtOrgName.resignFirstResponder()
        self.txtLocation.resignFirstResponder()

    }
    @objc func keyboardpreviousButton(){

        if myTextField == txtName {
            // self.txtConfirmPassword.becomeFirstResponder()
        }else if myTextField == txtEmail {
            self.txtName.becomeFirstResponder()
        }else if myTextField == txtOrgName {
            self.txtEmail.becomeFirstResponder()
        }else if myTextField == txtLocation {
            self.txtOrgName.becomeFirstResponder()
        }
    }



    @objc func rightButtonClicked(_ sender: Any) {
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
   
    override func viewDidLayoutSubviews() {
        UIView().setShadow(self.viewContainer)
        UIView().setShadowImg(self.imgBanner)
//        self.imgBanner.layer.cornerRadius = 5.0
//        self.imgBanner.clipsToBounds = true
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
       
        
//        print(self.viewScroll.frame.height)
        print(self.viewContainer.frame.origin.y+self.viewContainer.frame.size.height)
       

        let frame = self.viewScroll.frame.height-(self.viewContainer.frame.origin.y+self.viewContainer.frame.size.height)
        
        
        if self.txtName.text?.count == 0{
            self.showToastForQue(message: "Please enter your name",y:frame + self.viewContainer.frame.origin.y+self.viewContainer.frame.size.height)
        }
        else{
            self.txtOrgName.resignFirstResponder()
            self.txtName.resignFirstResponder()
            self.appUserObject?.lastName = self.txtName.text
            self.appUserObject?.countryCode = self.txtOrgName.text
            self.appUserObject?.locality = self.txtLocation.text
            self.appUserObject?.emailAlternate = self.txtEmail.text
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
        textField.setLeftPaddingPoints(10)
            myTextField = textField
        // self.moveTextField(textField: textField, moveDistance: -20, up: true)
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = inputToolbar

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
      //  self.moveTextField(textField: textField, moveDistance: -20, up: false)
       // self.scrollView.scrollToBottom(animated: true)
        if textField == txtName {
            self.txtEmail.becomeFirstResponder()
        }else if textField == txtEmail {
            self.txtOrgName.becomeFirstResponder()
        }else if textField == txtOrgName {
            self.txtLocation.becomeFirstResponder()
        }

    }
 
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//    }


    
}
