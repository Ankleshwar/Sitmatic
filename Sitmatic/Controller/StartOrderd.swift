//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class StartOrderd: BaseViewController {
    
    
    
    @IBOutlet weak var lblQuestionValueCount: UILabel!
      var dicAnsData = Dictionary<String, String>()
     var strInce: String!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet weak var btnNext: UIButton!
    var count = 0
    @IBOutlet weak var btnCancle: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var txtSecondField: UITextField!
    var arrIteam :Array<Any>?
    @IBOutlet weak var lblQuestion: UILabel!
    var strValue: String!
    var arrQuestion = [[String: Any]]()
    var arrHeightft = [[:]]
     var arrAnswer = NSMutableArray()
    var serverArraySecond: [[String: String]]  = Array()
     var dicData = Dictionary<String, Any>()
    var arrInch :Array<Any>?
    var ansStrIn: String!
    var isFirstQuestion: Bool!
    
    @IBOutlet weak var tostView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrQuestion = (setDataWithLocalJson("NextVersion") as NSArray as? Array<Dictionary<String, Any>>)!
        lblQuestion.text = arrQuestion[0]["questionText"] as? String
        self.arrIteam = arrQuestion[0]["value"] as? Array
        let id : Int = (arrQuestion[count]["questionId"] as? Int)!
        self.arrInch = arrQuestion[0]["inch"] as? Array
        self.isFirstQuestion = true
        self.lblQuestionValueCount.text = String(id) + " " + "of 24 Questions"
        self.strInce = "0"
        self.strValue = "3"
        self.ansStrIn = "36"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        showPicker()
         self.btnPrevious.isHidden = false
        
    }
    
    
    func showPicker(){
        
        self.txtField.inputView = self.pickerView
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtField.inputAccessoryView = toolBar
        
        
    }
    
    @objc func donedatePicker(){
        
        if(self.isFirstQuestion == true){
            if strValue == "ft"{
                self.showToast(message: "Please select a valid value")
            }else if strInce == "in" {
                self.showToast(message: "Please select a valid value")
            }
            else{
                 self.txtField.text = strValue + "ft" + " "  + strInce + "in"
            }
                
                
           
        }
        else{
             self.txtField.text = strValue
        }
        self.view.endEditing(true)
       
        
    }
    
    
    
    func setShadow(_ view: UIButton){
        
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        
    }
    
  
        
        
        
        
    
        
    
    
    
    @IBAction func clickToNext(_ sender: Any) {
        
       
        
        if self.txtField.text?.count == 0 {
            
            
            self.showToast(message: "Please select a valid option")
            
        }else{
            let id : Int = (arrQuestion[count]["questionId"] as? Int)!
            self.btnPrevious.isHidden = false
            if (self.arrQuestion.count == count){
                //self.showToast(message: "Thanku")
            }
            else{
                
                if(self.isFirstQuestion == true){
                    dicData["selected"] = self.txtField.text
                    self.ansStrIn = String(Int(strValue)!*12 + Int(strInce)!)
                    dicAnsData["ans"] = self.ansStrIn
                }
                else{
                    dicData["selected"] = strValue
                    dicAnsData["ans"] = dicData["selected"] as? String
                }
                
                
               
                let arr : Array<Any>? = arrQuestion[count]["value"] as? Array
                dicData["questionId"] = String(id)
              
                dicData["questionText"] = arrQuestion[count]["questionText"] as? String
              
            
                self.isFirstQuestion = false
                dicData["value"] = arr
                self.arrAnswer.add(dicData)
                //var strId = String(id)
                self.serverArraySecond = self.serverArraySecond.filter { !$0.values.contains(String(id)) }
                
                dicAnsData["id"] = String(id)
              
                self.serverArraySecond.append(dicAnsData)
               
                print(self.serverArraySecond)
                
                if id == 12{
                    
                
                    let vc = OrderProccessingSecond(nibName: "OrderProccessingSecond", bundle: nil)
                    vc.serverArrayThid = serverArraySecond
                   
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    count += 1
                     self.txtField.text = ""
                    lblQuestion.text = arrQuestion[count]["questionText"] as? String
                    let id : Int = (arrQuestion[count]["questionId"] as? Int)!
                    self.lblQuestionValueCount.text = String(id) + " " + "of 24 Questions"
                    self.arrIteam?.removeAll()
                    self.arrIteam = arrQuestion[count]["value"] as? Array
                }
               
                
            }
            
            
        }
            
        
        
        
    }
    
    @IBAction func clickToPrevious(_ sender: Any) {
        
        
       
        if isFirstQuestion ==  true{
            self.navigationController?.popViewController(animated: true)
        }else{
            count -= 1
            
            if (self.arrQuestion.count == 0){
                
            }
            else{
                
                
                var dicdata  = arrAnswer[count] as! [String : Any]
                let id: String! = dicdata["questionId"] as? String
                self.lblQuestionValueCount.text = id + " " + "of 24 Questions"
                if id == "5"{
                    self.btnPrevious.isHidden =  false
                    self.isFirstQuestion = true
                    
                    
                }
                lblQuestion.text = dicdata["questionText"] as? String
                self.txtField.text = dicdata["selected"] as? String
                self.arrIteam = dicdata["value"] as? Array<Any>
                
             
                if self.isFirstQuestion == true{
                    let strMain = dicdata["selected"] as! String
                    let fullNameArr = strMain.components(separatedBy: " ")
                    self.strValue =  fullNameArr[0]
                    self.strInce = fullNameArr[1]
                }
                else{
                    self.strValue = self.txtField.text
                }
                
                
           
                
                self.arrAnswer.removeObject(at: count)
                serverArraySecond.remove(at: count)
                
            }
        }
        
        

        
    }
    @IBAction func clickToCancle(_ sender: Any) {
      
        
        _ = SweetAlert().showAlert("Confirm Cancellation", subTitle: "Are you sure you want to cancel this order?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
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
    
    
    
    
    //{"questionId":5.1,"questionText":"Select Your Height in Ic.","value":["1","2","3","4","5","6","7","8","9","10","11"]}
    
    
    
    
}
extension StartOrderd : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        if self.isFirstQuestion ==  true {
            return 2
        }
        else{
                 return 1
        }
        
       
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
   
        if self.isFirstQuestion ==  true {
            if component == 0{
                return arrIteam!.count
            }
            else{
                return arrInch!.count
            }
        }
        else{
             return arrIteam!.count
        }
        
        
        
       
    }
    
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if self.isFirstQuestion ==  true {
            if component == 0{
                return arrIteam?[row] as? String
            }
            else{
                return arrInch?[row] as? String
            }
        }
        else{
            return arrIteam?[row] as? String
        }
        
        
  
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if self.isFirstQuestion ==  true {
            if component == 0{
               self.strValue = arrIteam?[row] as? String
            }
            else{
               self.strInce = arrInch?[row] as? String
            }
        }
        else{
           self.strValue = arrIteam?[row] as? String
        }
        
        
    }
}
extension StartOrderd: UITextFieldDelegate{
    
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(5)
        self.pickerView.reloadAllComponents()
    }
    

    
}

