//
//  OrderProccessing.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 07/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import Toast_Swift


class OrderProccessing: BaseViewController {
    
    @IBOutlet weak var tostView: UIView!
    @IBOutlet weak var tostLable: UILabel!
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var arrQuestion: Array<Dictionary<String,Any>>?
    var arrAnswer = NSMutableArray()
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    var isYesbtnTap : Bool!
    var strSelected : String!
    var dicData = Dictionary<String, String>()
    @IBOutlet weak var lblNo: UILabel!
    var arrNext = [[:]]
    var dicNext  = Dictionary<String, String>()
    @IBOutlet weak var btnprevious: UIButton!
    var arrayPersnonID: [String] = []
      var customViewAlert: UIView!
    @IBOutlet weak var btnNext: UIButton!
     var isPreviousClick : Bool!
    
    var  value: Int = 0
    
    @IBOutlet weak var lblQuestionValueCount: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
        setInitial()
        
    }
    
    
    
    
    func setInitial(){
        self.lblYes.text = arrQuestion?[0]["option1"] as? String
        self.lblNo.text = arrQuestion?[0]["option2"] as? String
        //self.lblQuestion.text  = arrQuestion?[0]["queText"] as? String
        
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        //self.lblQuestion.text  = strID + " " + quename
        self.lblQuestion.text  =   quename
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
        self.arrayPersnonID.append("1")
        self.arrayPersnonID.append("2")
        self.arrayPersnonID.append("3")
        self.btnprevious.isHidden = true
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickToPrivious(_ sender: Any) {
        print(value)
        
        if (value == 0){
            self.btnprevious.isHidden = true
            ECSAlert().showAlert(message: "Thanku", controller: self)
        }
        else{
            
            
            dicNext["selected"] = strSelected
            dicNext["option1"] = arrQuestion?[value]["option1"] as? String
            dicNext["option2"] = arrQuestion?[value]["option2"] as? String
            dicNext["queText"] = arrQuestion?[value]["queText"] as? String
            dicNext["queId"] = arrQuestion?[value]["queId"] as? String
            
            self.arrNext.insert(dicNext, at: 0)
            
            
            self.arrQuestion?.remove(at: value)
            self.arrayPersnonID.remove(at: value)
            value -= 1
            
            setPreviousData(valueindex: value)
            self.arrAnswer.removeObject(at: value)
            self.isPreviousClick = true
            
            
        }
        
    }
    
    
    func setValuenext(){
        

    }
    
    
    func showToast(){
        var style = ToastStyle()
        style.activitySize = CGSize(width: CGFloat(self.screenWidth), height: 40.0)
        style.messageFont = UIFont(name: "Roboto", size: 15.0)!
        style.messageColor = UIColor.white
        style.messageAlignment = .center
        style.backgroundColor = UIColor.darkBlue
        self.tostView.makeToast(" Please select a valid option for start order   ", duration: 2.0, position: .top, style: style )

        
    }
    
    
    @IBAction func clickToCancel(_ sender: Any) {
       
        
        
        _ = SweetAlert().showAlert("Confirm Cancellation", subTitle: "Are you sure you want to cancel this order?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
             
            }
            else {
             
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
    @IBAction func clickToNext(_ sender: Any) {
        
    
        if self.isYesbtnTap == false  {
           
            self.showToast(message: " Please select a valid option for start order ")
           //showToast()
        }
        else{
            
            nextQues()
           // self.btnNext.isHidden = true
             self.btnNext.isEnabled = false
        }
        
    }
    
    
    func nextQues(){
        
        
        
        if isYesbtnTap == false{
            self.showToast(message: "Please select option")
        }else{
            
            dicData["selected"] = strSelected
            dicData["option1"] = arrQuestion?[value]["option1"] as? String
            dicData["option2"] = arrQuestion?[value]["option2"] as? String
            dicData["queText"] = arrQuestion?[value]["queText"] as? String
            dicData["queId"] = arrQuestion?[value]["queId"] as? String
            
            self.arrAnswer.add(dicData)
            self.btnprevious.isHidden = false
            
            
            if (self.arrQuestion?.count == value){
                ECSAlert().showAlert(message: "Que overThanku", controller: self)
            }
            else{
                if self.isPreviousClick == true{
                    value += 1
                    setData(value: value)
                }else{
                    value += 1
                    setData(value: value)
                }
                
                
                
                
                
                
                
            }
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func clickToBtnYes(_ sender: Any) {
        self.btnYes.setButtonImage("on.png")
        self.btnNo.setButtonImage("off.png")
        self.btnNext.isEnabled = false
        self.isYesbtnTap = true
        self.strSelected = "Yes"
        let strId = arrQuestion?[value]["queId"] as? String
        self.isPreviousClick = false
        
        if strId == "5Y"{
            
            goToNext()
        }
            
        else if strId == "4"{
            goToNext()
        }
        else{
            
            if strId == "2"{
                if let index = self.arrayPersnonID.index(of: "3") {
                    print(index)
                    
                }
                    
                else{
                    self.arrQuestion?.append(["queId": "3","queText": "Do you like a chair with armrests?", "option1":"Left","option2":"Right"])
                    
                    self.arrayPersnonID.append("3")
                }
            }
                
                
            else if strId == "3"{
                
                if let index = self.arrayPersnonID.index(of: "3Y") {
                    print(index)
                }
                else{
                    self.arrQuestion?.append(["queId": "3Y","queText": "Did you have corrective eye surgery?", "option1":"Yes","option2":"No"])
                    self.arrayPersnonID.append("3Y")
                }
                
                
            }
            if strId == "3Y"{
                
                if let index = self.arrayPersnonID.index(of: "4Y") {
                    print(index)
                }
                else{
                    self.arrQuestion?.append(["queId": "4Y","queText": "Was it monovision correction? (Was one eye corrected for reading and the other corrected for distance?", "option1":"Yes","option2":"No"])
                    self.arrayPersnonID.append("4Y")
                }
                
                
            }
            else if strId == "4Y"{
                
                if let index = self.arrayPersnonID.index(of: "5Y") {
                    print(index)
                    
                }
                else{
                    self.arrQuestion?.append(["queId": "5Y","queText": "Which eye was corrected for reading?", "option1":"Left","option2":"Right"])
                    
                    self.arrayPersnonID.append("5Y")
                    
                }
                
            }
            
            
            
            nextQues()
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    func goToNext(){
        let vc = StartOrderd(nibName: "StartOrderd", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func clickToBtnNo(_ sender: Any) {
         self.btnNext.isEnabled = false
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("on.png")
        self.isYesbtnTap = true
        self.isPreviousClick = false
        self.strSelected = "No"
        let strId = arrQuestion?[value]["queId"] as? String
        
        
        if strId == "4"{
            goToNext()
        }
        else if strId == "5Y"{
            
            goToNext()
        }
        else{
            
            if strId == "2"{
                if let index = self.arrayPersnonID.index(of: "3") {
                    print(index)
                    
                }
                    
                else{
                    self.arrQuestion?.append(["queId": "3","queText": "Do you like a chair with armrests?", "option1":"Left","option2":"Right"])
                    
                    self.arrayPersnonID.append("3")
                }
            }
            else{
                if let index = self.arrayPersnonID.index(of: "4") {
                    print(index)
                    
                }
                    
                else{
                    self.arrQuestion?.append(["queId": "4","queText": "Which is your dominant eye?", "option1":"Left","option2":"Right"])
                    
                    self.arrayPersnonID.append("4")
                }
            }
            
            
            
            nextQues()
        }
        
        
    }
    
    
    func setData(value : Int){
        
        
        self.lblYes.text = arrQuestion?[value]["option1"] as? String
        self.lblNo.text = arrQuestion?[value]["option2"] as? String
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        //self.lblQuestion.text  = strID + " " + quename
        self.lblQuestion.text  =   quename
        
        self.lblQuestionValueCount.text = strID + " " + "of 24 Questions"
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
    }
    
    func setPreviousData(valueindex : Int){
        
        
        
        
        var dicdata  = arrAnswer[valueindex] as! [String: String]
        
        self.lblYes.text = dicdata["option1"]
        self.lblNo.text = dicdata["option2"]
        let strID = dicdata["queId"]
        let quename = dicdata["queText"]
        //self.lblQuestion.text  = strID! + " " + quename!
        self.lblQuestion.text  =   quename!
        self.lblQuestionValueCount.text = strID! + " " + "of 24 Questions"
        let selctedValue = dicdata["selected"]
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        
        
        if selctedValue == "Yes"{
            self.btnYes.setButtonImage("on.png")
            self.btnNo.setButtonImage("off.png")
        }
        else if selctedValue == "No"{
            self.btnYes.setButtonImage("off.png")
            self.btnNo.setButtonImage("on.png")
        }
        
        if strID == "1"{
            self.btnprevious.isHidden = true
            
            self.btnNext.isEnabled = true
            
            self.arrayPersnonID.removeAll()
            value = 0
            self.arrayPersnonID.append("1")
            self.arrayPersnonID.append("2")
            self.arrayPersnonID.append("3")
            arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
            
        }
        
        
        
        self.isPreviousClick = true
        
        self.isYesbtnTap = true
    }
    
    
}

