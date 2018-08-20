//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

protocol  StartOrderdDelegate {
    func setDataOnBack(isBack:Bool,arrSaveValue:[[String: String]])
}



class StartOrderd: BaseViewController , OrderProccessingSecondDelegate{
    
    
    var arrCurrent: [[String: String]]  = Array()
    var isBack = false
    var isButtonCheck = false
    var isPriviousClick = false
    @IBOutlet weak var lblQuestionValueCount: UILabel!
    var dicAnsData = Dictionary<String, String>()
    var strInce: String!
    var delegate: StartOrderdDelegate?
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
    var arrAnswer: [[String: String]]  = Array()
    var serverArraySecond: [[String: String]]  = Array()
    var dicData = Dictionary<String, String>()
    var arrInch :Array<Any>?
    var ansStrIn: String!
    var isFirstQuestion: Bool!
    
    @IBOutlet weak var tostView: UIView!
    fileprivate func setPickerOrder() {
        let countSize = (self.arrIteam?.count)!/2
        self.pickerView.selectRow(countSize, inComponent: 0, animated: true)
        self.pickerView(pickerView, didSelectRow: countSize, inComponent: 0)
      
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrQuestion = (setDataWithLocalJson("NextVersion") as NSArray as? Array<Dictionary<String, Any>>)!
        self.isFirstQuestion = true
        self.strInce = "0"
        self.strValue = "3"
        self.ansStrIn = "36"
          print("viewDidLoadCall")
        if arrCurrent.isEmpty == false{
            
        
                    let iD : Int = (arrQuestion[count]["questionId"] as? Int)!
                    let index = arrCurrent.index(where: {$0["questionId"] == String(iD)})
                    var  dicLocal = arrCurrent[index!]
            
            if iD == 5{
                let strValueIn = dicLocal["selected"]
         
               
                
                var  fullNameArr = strValueIn?.components(separatedBy: " ")
                strValue = fullNameArr![0]
                strInce =  fullNameArr![1]
                if NSString(string: strValue).contains("ft") {
                    
                    strValue = String(strValue.dropLast(2))
                    print(strValue)
                }
                if NSString(string: strInce).contains("in") {
                    
                    strInce = String(strInce.dropLast(2))
                    print(strInce)
                }
                
                self.ansStrIn = String(Int(strValue)!*12 + Int(strInce)!)
               
                
                
                self.txtField.text = dicLocal["selected"]
                

            
                
            }else{
                self.txtField.text = dicLocal["selected"]
                self.strValue = dicLocal["selected"]
            }
            
                    lblQuestion.text = dicLocal["questionText"]
        
                    self.lblQuestionValueCount.text = dicLocal["questionId"]! + " " + "of 19 Questions"
                    self.arrIteam?.removeAll()
                    self.arrIteam = arrQuestion[count]["value"] as? Array
                    self.arrInch = arrQuestion[0]["inch"] as? Array
                    self.arrIteam = arrQuestion[0]["value"] as? Array
                    setPickerOrder()
   
                    self.arrAnswer.append(dicLocal)
                    self.isPriviousClick = true
        
                }else{
        
                    lblQuestion.text = arrQuestion[0]["questionText"] as? String
                    self.arrIteam = arrQuestion[0]["value"] as? Array
                    let id : Int = (arrQuestion[count]["questionId"] as? Int)!
                    self.arrInch = arrQuestion[0]["inch"] as? Array
                    self.arrIteam = arrQuestion[0]["value"] as? Array
                    self.lblQuestionValueCount.text = String(id) + " " + "of 19 Questions"
                    self.strValue = ""
                    setPickerOrder()

          }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        showPicker()
        self.btnPrevious.isHidden = false
          print("viewWillAppearCall")
    }
    
    
    func showPicker(){
        
        self.txtField.inputView = self.pickerView
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtField.inputAccessoryView = toolBar
        
        
    }
    
    func setData(arrData:[[String: String]],isbackValue:Bool){
        arrAnswer = arrData
        isBack = isbackValue
        self.isButtonCheck = true
        self.txtField.isEnabled = true
    }
    
    @objc func donedatePicker(){
        
        if(self.isFirstQuestion == true){
            if strValue == "ft"{
                //self.showToast(message: "Please select a valid value")
                strValue = "3"
                
                
            }else if strInce == "in" {
                //self.showToast(message: "Please select a valid value")
                strInce = "0"
                
            }
            else{
                
                if NSString(string: strValue).contains("ft") {
                    
                    strValue = String(strValue.dropLast(2))
                    print(strValue)
                }
                if NSString(string: strInce).contains("in") {
                    
                    strInce = String(strInce.dropLast(2))
                    print(strInce)
                }
                
                self.txtField.text = strValue + "ft" + " "  + strInce + "in"
                textField(color:UIColor.lightGray)
            }
            
            self.txtField.text = strValue + "ft" + " "  + strInce + "in"
            
        }
        else{
            self.txtField.text = strValue
            textField(color:UIColor.lightGray)
        }
        
        self.isPriviousClick = false
        
        self.view.endEditing(true)
//        self.view.isUserInteractionEnabled = false
//        Timer.scheduledTimer(timeInterval: 0.6,
//                             target: self,
//                             selector: #selector(self.setDataOnNext),
//                             userInfo: nil,
//                             repeats: false)
    }
    
    
    
    func setShadow(_ view: UIButton){
        
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    fileprivate func textField(color:UIColor) {
        self.txtField.layer.borderWidth = 1.0
        self.txtField.layer.borderColor = color.cgColor
        self.txtField.layer.cornerRadius = 5.0
    }
    
    @objc fileprivate func setDataOnNext() {
        var dicLocal = [String : String]()
        
        if self.txtField.text?.count == 0 {
            
            
            self.showToast(message: "Please select a valid option")
            textField(color:UIColor.red)
            
            
        }else{
            let id : Int = (arrQuestion[count]["questionId"] as? Int)!
            self.btnPrevious.isHidden = false
            if (self.arrQuestion.count == count){
                //self.showToast(message: "Thanku")
            }
            else{
                
                if isButtonCheck == true{
                    
                    isButtonCheck = false
                }
                
                
                
                
                if(self.isFirstQuestion == true){
                    
                    dicData["selected"] = self.txtField.text
                    dicLocal["selected"] = self.txtField.text
                    
                    if NSString(string: strValue).contains("ft") {
                        
                        strValue = String(strValue.dropLast(2))
                        print(strValue)
                    }
                    if NSString(string: strInce).contains("in") {
                        
                        strInce = String(strInce.dropLast(2))
                        print(strInce)
                    }
                    
                    self.ansStrIn = String(Int(strValue)!*12 + Int(strInce)!)
                    dicAnsData["ans"] = self.ansStrIn
                    
                }
                else{
                    
                    
                   
                        dicData["selected"] = strValue
                        dicLocal["selected"] = strValue
                        dicAnsData["ans"] = dicData["selected"]
                    
                    
                   
                }
                
                
                
               
                dicData["questionId"] = String(id)
                dicLocal["questionId"] = String(id)
                dicData["questionText"] = arrQuestion[count]["questionText"] as? String
                dicLocal["questionText"] = arrQuestion[count]["questionText"] as? String
                
                
                
                
                
                
                
                
                
                self.isFirstQuestion = false
                
                
                
                self.serverArraySecond = self.serverArraySecond.filter { !$0.values.contains(String(id)) }
                
                dicAnsData["id"] = String(id)
                
                self.serverArraySecond.append(dicAnsData)
                
                
                
                if id == 12{
                    print(self.serverArraySecond)
                    self.arrAnswer = self.arrAnswer.filter { !$0.values.contains(String(id)) }
                    self.arrAnswer.append(dicData)
                    self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(String(id)) }
                    self.arrCurrent.append(dicLocal)
                   
                    self.txtField.isEnabled = false
                    self.isButtonCheck = true
                    let vc = OrderProccessingSecond(nibName: "OrderProccessingSecond", bundle: nil)
                    vc.serverArrayThid = serverArraySecond
                    vc.delegate = self
                    vc.arrPreviousControllerData = arrAnswer
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                 
                }
                else{
                    self.txtField.isEnabled = true
                    count += 1
                    
                    
                    if isPriviousClick == true {
                        
                        
                        
                        
                        let iD : Int = (arrQuestion[count]["questionId"] as? Int)!
                        let index = arrCurrent.index(where: {$0["questionId"] == String(iD)})
                        
                        if index != nil {
                            
                            if(self.isFirstQuestion == true){
                                self.isFirstQuestion = false
                            }
                            
                            var  dicLocal = arrCurrent[index!]
                            
                            print(dicLocal)
                            
                            
                            self.txtField.text = dicLocal["selected"]
                            self.strValue = dicLocal["selected"]
                            lblQuestion.text = dicLocal["questionText"]
                            
                            self.lblQuestionValueCount.text = dicLocal["questionId"]! + " " + "of 19 Questions"
                            self.arrIteam?.removeAll()
                            self.arrIteam = arrQuestion[count]["value"] as? Array
                            
                            
                              self.arrAnswer = self.arrAnswer.filter { !$0.values.contains(dicLocal["questionId"]!) }
                            self.arrAnswer.append(dicLocal)
                            
                            
                        }
                        else{
                            
                            //                            self.arrAnswer = self.arrAnswer.filter { !$0.values.contains(String(id)) }
                            //                            self.arrAnswer.append(dicData)
                            //                            self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(String(id)) }
                            //                            self.arrCurrent.append(dicLocal)
                            
                            self.txtField.text = ""
                            lblQuestion.text = arrQuestion[count]["questionText"] as? String
                            let id : Int = (arrQuestion[count]["questionId"] as? Int)!
                            self.lblQuestionValueCount.text = String(id) + " " + "of 19 Questions"
                            self.arrIteam?.removeAll()
                            self.arrIteam = arrQuestion[count]["value"] as? Array
                            
                            
                            
                            
                            //                            self.strValue = ""
                            //                            self.pickerView.selectRow(0, inComponent: 0, animated: true)
                            //                            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
                            
                            
                        }
                        
                    }else{
                        
                        
                        self.arrAnswer = self.arrAnswer.filter { !$0.values.contains(String(id)) }
                        self.arrAnswer.append(dicData)
                        self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(String(id)) }
                        self.arrCurrent.append(dicLocal)
                        
                        self.txtField.text = ""
                        lblQuestion.text = arrQuestion[count]["questionText"] as? String
                        let id : Int = (arrQuestion[count]["questionId"] as? Int)!
                        self.lblQuestionValueCount.text = String(id) + " " + "of 19 Questions"
                        self.arrIteam?.removeAll()
                        self.arrIteam = arrQuestion[count]["value"] as? Array
                        self.strValue = ""
                       
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            
            
        }
        self.view.isUserInteractionEnabled = true
    }
    
    @IBAction func clickToNext(_ sender: Any) {
        
        
        
        
        setDataOnNext()
        
        
        
        
        
        
    }
    
    @IBAction func clickToPrevious(_ sender: Any) {
        self.isButtonCheck = false
        
        textField(color:UIColor.white)
        if isFirstQuestion ==  true{
            self.delegate?.setDataOnBack(isBack:true, arrSaveValue: arrCurrent)
            self.navigationController?.popViewController(animated: true)
        }else{
            
            if isBack == true{
              
                isBack = false
            }
            
            count -= 1
            
            if (count == -1){
                self.navigationController?.popViewController(animated: true)
            }
                
            else{
                
                var dicdata = [String : String]()
                let iD : Int = (arrQuestion[count]["questionId"] as? Int)!
                let index = arrAnswer.index(where: {$0["questionId"] == String(iD)})
                
                
                
                if index != nil{
                    dicdata  = arrAnswer[index!]
                }
                
                let id: String! = dicdata["questionId"]
                self.lblQuestionValueCount.text = id + " " + "of 19 Questions"
                if id == "5"{
                    self.btnPrevious.isHidden =  false
                    self.isFirstQuestion = true
                    
                    
                }
                lblQuestion.text = dicdata["questionText"]
                self.txtField.text = dicdata["selected"]
                self.arrIteam = arrQuestion[count]["value"] as? Array
                
                
                if self.isFirstQuestion == true{
                    
                    let strMain = dicdata["selected"]
                    let fullNameArr = strMain?.components(separatedBy: " ")
                    self.strValue =  fullNameArr![0]
                    self.strInce = fullNameArr![1]
                    arrQuestion = (setDataWithLocalJson("NextVersion") as NSArray as? Array<Dictionary<String, Any>>)!
                }
                else{
                    self.strValue = self.txtField.text
                }
                
                self.isPriviousClick = true
                
       
                
            }
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
        
        var indexArray = Int()
        print(self.strValue)
        for i in 0..<arrIteam!.count {
            let str = arrIteam?[i] as! String
            if str == self.strValue{
                indexArray = i
            }
            
        }
        
        print(indexArray)
        
        if isPriviousClick == false {
            self.pickerView.reloadAllComponents()
            let countSize = (self.arrIteam?.count)!/2
            self.pickerView.selectRow(countSize, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: countSize, inComponent: 0)
            
        }else{
            
            self.pickerView.selectRow(indexArray, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: indexArray, inComponent: 0)
        }
        
        
    
        textField.setLeftPaddingPoints(5)
     
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
    
}

extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

