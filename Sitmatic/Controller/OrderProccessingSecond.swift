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

class OrderProccessingSecond: BaseViewController {
    
    @IBOutlet weak var tostView: UIView!
    @IBOutlet weak var tostLable: UILabel!
    
    
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
    var arrNext = [[:]]
    var dicNext  = Dictionary<String, String>()
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
        arrQuestion = setDataWithLocalJson("OrderProccessingSecond") as NSArray as? Array<Dictionary<String, Any>>
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
         self.lblQuestionValueCount.text = strID + " " + "of 24 Questions"
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
        self.arrayPersnonID.append("1")
        self.arrayPersnonID.append("2")
        self.arrayPersnonID.append("3")
        //self.btnprevious.isHidden = true
        self.isFirstQue =  true
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickToPrivious(_ sender: Any) {
        print(value)
        
        
        if isFirstQue == true {
            self.navigationController?.popViewController(animated: true)
        }
        else{
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
        style.messageFont = UIFont(name: "Roboto", size: 15.0)!
        style.messageColor = UIColor.white
        style.messageAlignment = .center
        style.backgroundColor = UIColor.darkBlue
        self.tostView.makeToast(" Please select a valid option for start order   ", duration: 2.0, position: .top, style: style )

        
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
    
    
    @IBAction func clickToNext(_ sender: Any) {
        
    
        if self.isYesbtnTap == false  {
           
            self.showToast(message: " Please select a valid option for start order ")
           //showToast()
        }
        else{
            
            nextQues()
            self.btnNext.isEnabled = false
        }
        
    }
    
    
    func nextQues(){
        
        self.isFirstQue = false
        
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
            
            _ = arrQuestion?[value]["queId"] as! String
            
            dicAnsData["id"] = arrQuestion?[value]["queId"] as? String
            dicAnsData["ans"] = strSelected
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
        self.btnNext.isEnabled = false
        self.isYesbtnTap = true
        self.strSelected = "Yes"
        let strId = arrQuestion?[value]["queId"] as? String
        self.isPreviousClick = false
        
        if strId == "14"{
            
            callApi()
        } else if strId == "15"{
            setNextData()
        }else{
                 nextQues()
        }
     
            
            
            
        
            
}
        
    func setNextData(){
        let vc = ModifieModel(nibName: "ModifieModel", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
        
        
        
        
    
    
    
    func callApi(){
        
     
     
        
     print(serverArrayThid)
        
        
        
        
        
        let strJson = self.json(from: serverArrayThid)
        print(strJson ?? "")
        
        self.callGenrateModelApi(strData :strJson!)
        
    }
    
    

    
    
    
    
    
    
    func callGenrateModelApi(strData : String){
        
        let dic = ["data": strData]

        
        
        SVProgressHUD.show()
        
        ServiceClass().getModel(strUrl: "savebasicquestions", param: dic as [String : AnyObject] ) { error, dicdata in
            
            if error != nil{
                print(dicdata)
                
        
                
                SVProgressHUD.dismiss()
            }else{

                let strMessage = "We’re almost done! Your ideal chair model is:" + "Model Number :3&&&&" + "Need to make a change or add something?"
                
                self.arrQuestion?.append(["queId": "15","queText": strMessage , "option1":"Yes","option2":"No"])
                self.nextQues()
                
                 SVProgressHUD.dismiss()
                
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func clickToBtnNo(_ sender: Any) {
        self.btnNext.isEnabled = false
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("on.png")
        self.isYesbtnTap = true
        self.isPreviousClick = false
        self.strSelected = "No"
        let strId = arrQuestion?[value]["queId"] as? String
        
        
        if strId == "14"{
            callApi()
        }else    if strId == "15"{
           setNoNextScreen()
        }
        else{
            nextQues()
        }
        
        
    }
    
    func setNoNextScreen(){
       let vc = OrderProccessingThird(nibName: "OrderProccessingThird", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setData(value : Int){
        
        
        self.lblYes.text = arrQuestion?[value]["option1"] as? String
        self.lblNo.text = arrQuestion?[value]["option2"] as? String
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        
        
        
        
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
        
        if strID == "13"{
            
            
            self.btnNext.isEnabled = true
            self.isFirstQue = true
            self.arrayPersnonID.removeAll()
            value = 0
            self.arrayPersnonID.append("13")
         
            arrQuestion = setDataWithLocalJson("OrderProccessingSecond") as NSArray as? Array<Dictionary<String, Any>>
            
        }
        
        
        
        self.isPreviousClick = true
        
        self.isYesbtnTap = true
    }
    
    
}


extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
