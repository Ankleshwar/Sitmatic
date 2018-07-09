//
//  OrderProccessing.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 07/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD

class OrderProccessingThird: BaseViewController {
    
  var strValue: String = ""
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet weak var btnCancle: UIButton!
    
    @IBOutlet weak var tostView: UIView!
    @IBOutlet weak var tostLable: UILabel!
    
    @IBOutlet var viewShowModel: UIView!
    var arrIteam :Array<Any>?
    @IBOutlet weak var lblModel: UILabel!
    var dicAnsData = Dictionary<String, String>()
    var isFirstQue: Bool!
    @IBOutlet weak var tableView: UITableView!
    var arrQuestion: Array<Dictionary<String,Any>>?
    var arrAnswer = NSMutableArray()
    var arrPreviousControllerData = NSMutableArray()
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    var isYesbtnTap : Bool!
    var strSelected : String!
    var dicData = Dictionary<String, String>()
    @IBOutlet weak var lblNo: UILabel!
    
   
    @IBOutlet weak var btnprevious: UIButton!
    var arrayPersnonID: [String] = []
    var customViewAlert: UIView!
    @IBOutlet weak var btnNext: UIButton!
     var isPreviousClick : Bool!
     var serverArrayThid: [[String: String]]  = Array()
    var  value: Int = 0
    
    @IBOutlet weak var lblQuestionValueCount: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtColor.isHidden = true
        arrQuestion = setDataWithLocalJson("OrderProccessingThird") as NSArray as? Array<Dictionary<String, Any>>
        setInitial()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        showPicker()
        
        
    }
    
    
    func showPicker(){
        
        self.txtColor.inputView = self.pickerView
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtColor.inputAccessoryView = toolBar
        
        
    }
    
    @objc func donedatePicker(){
        
        self.txtColor.text = strValue
      
        self.view.endEditing(true)
        textField(color:UIColor.lightGray)
        Timer.scheduledTimer(timeInterval: 0.3,
                             target: self,
                             selector: #selector(self.callApi),
                             userInfo: nil,
                             repeats: false)
    }
    
    
    
    func setInitial(){
        self.lblYes.text = arrQuestion?[0]["option1"] as? String
        self.lblNo.text = arrQuestion?[0]["option2"] as? String
        //self.lblQuestion.text  = arrQuestion?[0]["queText"] as? String
        
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        //self.lblQuestion.text  = strID + " " + quename
        self.lblQuestion.text  =   quename
         self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"
        self.arrayPersnonID.append("17")
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
       
        self.btnprevious.isHidden = false
        self.isFirstQue =  true
    }
    
    @IBAction func clickToConfirmModel(_ sender: Any) {
    }
    
    

    @IBAction func clickToPrivious(_ sender: Any) {
        print(value)
        
        
        if isFirstQue == true {
            self.navigationController?.popViewController(animated: true)
        }
        else{
            if (value == 0){
                self.btnprevious.isHidden = true
                
            }
            else{
                
                

                
                self.arrQuestion?.remove(at: value)
                self.arrayPersnonID.remove(at: value)
                value -= 1
                
                setPreviousData(valueindex: value)
                self.arrAnswer.removeObject(at: value)
                 serverArrayThid.remove(at: value)
                self.isPreviousClick = true
                
                
            }
            
        }
        
        
    }
    
    
    func setValuenext(){
        

    }
    
    
    func showToast(){
        var style = ToastStyle()
        style.activitySize = CGSize(width: CGFloat(self.screenWidth), height: 40.0)
        style.messageFont = UIFont(name: "Roboto", size: 18.0)!
        style.messageColor = UIColor.white
        style.messageAlignment = .center
        style.backgroundColor = UIColor.darkBlue
        self.tostView.makeToast(" Please select a valid option ", duration: 2.0, position: .top, style: style )

        
    }
    
    
    @IBAction func clickToCancel(_ sender: Any) {
       
        
        
        _ = SweetAlert().showAlert("Confirm Cancellation", subTitle: "Are you sure you want to cancel this order?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                // _ = SweetAlert().showAlert("Cancelled!", subTitle: "Your Order Processing is safe", style: AlertStyle.error)
            }
            else {
                //_ = SweetAlert().showAlert("Deleted!", subTitle: "Your Order Processing has been deleted!", style: AlertStyle.success)
                let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
    
    
    fileprivate func setdataYes(strId:String) {
        if strId == "17"{
            if let index = self.arrayPersnonID.index(of: "18") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "18","queText": "Please select fabric category", "option1":"Category 2/Flexx","option2":"Category 4/Dreamweave"])
                self.arrayPersnonID.append("18")
            }
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
        }  else if strId == "17N"{
            if let index = self.arrayPersnonID.index(of: "18") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "18","queText": "Please select fabric category", "option1":"Category 2/Flexx","option2":"Category 4/Dreamweave"])
                self.arrayPersnonID.append("18")
            }
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
        }
        else if strId == "19"{
            callApi()
        }
            
        else if strId == "18" {
           
            if let index = self.arrayPersnonID.index(of: "19") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "19","queText": "Please select color", "value": ["Black","Indigo","Charcoal","Maroon"]])
                self.arrayPersnonID.append("19")
            }
            self.arrIteam = ["Black","Indigo","Charcoal","Maroon"]
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
            
        }else{
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
        }
    }
    
    fileprivate func setDataNo(strId:String) {
        if strId == "17N"{
            callApi()
        }else if strId == "19"{
            callApi()
        }
        
        else if strId == "18"{
            
            
            if let index = self.arrayPersnonID.index(of: "19") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "19","queText": "Please select color", "value": ["Navy","Charcoal","Aqua","Ember","Cologne","Napa","Tropicana"]])
                self.arrayPersnonID.append("19")
            }
             self.arrIteam = ["Navy","Charcoal","Aqua","Ember","Cologne","Napa","Tropicana"]
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
                
                
            
            
        }
        else    if strId == "17"{
            if let index = self.arrayPersnonID.index(of: "17N") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "17N","queText": "Are you ready to make an upholstery selection?", "option1":"Yes","option2":"No"])
                self.arrayPersnonID.append("17N")
            }
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
        }
        else{
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
        }
    }
    
    fileprivate func textField(color:UIColor) {
        self.txtColor.layer.borderWidth = 1.0
        self.txtColor.layer.borderColor = color.cgColor
        self.txtColor.layer.cornerRadius = 5.0
    }
    
    
    @IBAction func clickToNext(_ sender: Any) {
        
        
        textField(color:UIColor.lightGray)
        
        if (arrQuestion?[value]["queId"] as? String)! == "19"{
            
            if self.txtColor.text == ""{
                self.showToast(message: " Please select a color ")
                textField(color:UIColor.red)
            }else{
                textField(color:UIColor.lightGray)
                callApi()
            }
            
        }else{
            
            
            if self.isYesbtnTap == false  {
                
                self.showToast(message: " Please select a valid option  ")
                self.btnYes.setButtonImage("red.png")
                self.btnNo.setButtonImage("red.png")
            }
            else{
                print(strSelected)
                
                
                if strSelected == "No"{
                    setDataNo(strId: (arrQuestion?[value]["queId"] as? String)!)
                }
                    
                else{
                    setdataYes(strId: (arrQuestion?[value]["queId"] as? String)!)
                }
                
                nextQues()
                self.btnNext.isEnabled = true
            }
            
            
        }
        
        
        
    
     
            
          
        }
        
    
    
    
    @objc func nextQues(){
        
        self.isFirstQue = false
        
        if isYesbtnTap == false{
            
        }else{
            
            dicData["selected"] = strSelected
            dicData["option1"] = arrQuestion?[value]["option1"] as? String
            dicData["option2"] = arrQuestion?[value]["option2"] as? String
            dicData["queText"] = arrQuestion?[value]["queText"] as? String
            dicData["queId"] = arrQuestion?[value]["queId"] as? String
            
            self.arrAnswer.add(dicData)
            self.btnprevious.isHidden = false
            
            
       
            
            
            let strId = arrQuestion?[value]["queId"] as! String
            
           // dicAnsData["id"] = arrQuestion?[value]["queId"] as? String
            dicAnsData[strId] = strSelected
            self.serverArrayThid.append(dicAnsData)
            
            
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
        self.btnNext.isEnabled = true
        self.isYesbtnTap = true
        self.strSelected = "Yes"
        let strId = arrQuestion?[value]["queId"] as? String
        self.isPreviousClick = false
        
        setdataYes(strId: strId!)
        

        
     
            
        
            
        
            
}
        
    func setNextData(){
        let vc = ModifieModel(nibName: "ModifieModel", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
        
        
        
        
    
    
    
    @objc func callApi(){
        
        self.btnprevious.isHidden =  true
        self.btnNext.isEnabled = false
        self.btnCancle.isEnabled = false
        self.serverArrayThid = serverArrayThid.compactMap { $0 }
        
        print(serverArrayThid)
        
        
        
        
        
        let strJson = self.json(from: serverArrayThid)
        print(strJson ?? "")
        
        self.callGenrateModelApi(strData :strJson!)
        
    }
    
    

    
    
    
    
    
    
    func callGenrateModelApi(strData : String){
        
        let dic = ["data": strData]

        self.txtColor.isEnabled = false
        
        SVProgressHUD.show()
        
        ServiceClass().getModel(strUrl: "savebasicquestions", param: dic as [String : AnyObject] ) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                
             //   let strMessage = "We’re  done! Your ideal chair model is:" + "Model Number :#####"
                //self.lblModel.text = strMessage
                self.viewShowModel.frame = self.view.bounds
                self.view.addSubview(self.viewShowModel)
                
                SVProgressHUD.dismiss()
            }else{

                //let strMessage = "We’re  done! Your ideal chair model is:" + "Model Number :#####"
             //   self.lblModel.text = strMessage
                self.viewShowModel.frame = self.view.bounds
                self.view.addSubview(self.viewShowModel)
                
                 SVProgressHUD.dismiss()
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func clickToBtnNo(_ sender: Any) {
        self.btnNext.isEnabled = true
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("on.png")
        self.isYesbtnTap = true
        self.isPreviousClick = false
        self.strSelected = "No"
        let strId = arrQuestion?[value]["queId"] as? String
        
         setDataNo(strId: strId!)

        
        
    }
    
    
    func setData(value : Int){
        
        
        self.lblYes.text = arrQuestion?[value]["option1"] as? String
        self.lblNo.text = arrQuestion?[value]["option2"] as? String
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        
        
        
        
        self.lblQuestion.text  =   quename
        
        self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
        
        
        if (arrQuestion?[value]["queId"] as? String)! == "19"{
            self.txtColor.isHidden = false
            self.btnYes.isHidden = true
            self.btnNo.isHidden = true
            self.lblYes.isHidden = true
            self.lblNo.isHidden = true
        }else{
            self.txtColor.isHidden = true
            self.btnYes.isHidden = false
            self.btnNo.isHidden = false
            self.lblYes.isHidden = false
            self.lblNo.isHidden = false
        }
        
        
    }
    
    func setPreviousData(valueindex : Int){
        
        if (arrQuestion?[value]["queId"] as? String)! == "19"{
            self.txtColor.isHidden = false
            self.btnYes.isHidden = true
            self.btnNo.isHidden = true
            self.lblYes.isHidden = true
            self.lblNo.isHidden = true
        }else{
            self.txtColor.isHidden = true
            self.btnYes.isHidden = false
            self.btnNo.isHidden = false
            self.lblYes.isHidden = false
            self.lblNo.isHidden = false
        }
        
        
        
        
        var dicdata  = arrAnswer[valueindex] as! [String: String]
        
        self.lblYes.text = dicdata["option1"]
        self.lblNo.text = dicdata["option2"]
        let strID = dicdata["queId"]
        let quename = dicdata["queText"]
        //self.lblQuestion.text  = strID! + " " + quename!
        self.lblQuestion.text  =   quename!
        self.lblQuestionValueCount.text = strID! + " " + "of 19 Questions"
         strSelected = dicdata["selected"]
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        
        
        if strSelected == "Yes"{
            self.btnYes.setButtonImage("on.png")
            self.btnNo.setButtonImage("off.png")
        }
        else if strSelected == "No"{
            self.btnYes.setButtonImage("off.png")
            self.btnNo.setButtonImage("on.png")
        }
        
        if strID == "17"{
            
            
            self.btnNext.isEnabled = true
            self.isFirstQue = true
            self.arrayPersnonID.removeAll()
            value = 0
            self.arrayPersnonID.append("17")
         
            arrQuestion = setDataWithLocalJson("OrderProccessingThird") as NSArray as? Array<Dictionary<String, Any>>
            
        }
        
        
        
        self.isPreviousClick = true
        
        self.isYesbtnTap = true
    }
    
    
}




extension OrderProccessingThird : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
            return 1
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
   
            return arrIteam!.count
        
        
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
   
            return arrIteam?[row] as? String
        
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
     
        self.strValue = (arrIteam?[row] as? String)!
        
        
        
    }
}
extension OrderProccessingThird: UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(5)
        self.pickerView.reloadAllComponents()
    }
    
    
    
}

