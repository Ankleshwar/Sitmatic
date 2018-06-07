//
//  OrderProccessing.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 07/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class OrderProccessing: BaseViewController {
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
    
    @IBOutlet weak var btnNext: UIButton!
     var isPreviousClick : Bool!
    
    var  value: Int = 0
    

    @IBOutlet weak var lblQuestion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
           
        setInitial()
        
    }

    
    
    
    func setInitial(){
        self.lblYes.text = arrQuestion?[0]["option1"] as? String
        self.lblNo.text = arrQuestion?[0]["option2"] as? String
        self.lblQuestion.text  = arrQuestion?[0]["queText"] as? String
        
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        self.lblQuestion.text  = strID + quename
        
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
        
//        var dicdata  = arrNext[0] as! [String: String]
//
//        
//        self.lblYes.text = dicdata["option1"]
//        self.lblNo.text = dicdata["option2"]
//        let strID = dicdata["queId"]
//        let quename = dicdata["queText"]
//        self.lblQuestion.text  = strID! + quename!
//        self.btnYes.setButtonImage("off.png")
//        self.btnNo.setButtonImage("off.png")
//        self.arrQuestion?.append(dicdata)
//        print(arrQuestion)
    }
    
    
    
    @IBAction func clickToCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clickToNext(_ sender: Any) {
     
        if  self.isPreviousClick == true {
            ECSAlert().showAlert(message: "Please Reselect your data ", controller: self)
        }
        else if self.isYesbtnTap == false  {
            ECSAlert().showAlert(message: "Please select value ", controller: self)
        }
    }
    
    
    func nextQues(){
        
  
        
        if isYesbtnTap == false{
            ECSAlert().showAlert(message: "Please Select Value", controller: self)
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
        if strId == "3"{
            
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
                if let index = self.arrayPersnonID.index(of: "4") {
                    print(index)
                    
                }
                    
                else{
                    self.arrQuestion?.append(["queId": "4","queText": "Which is your dominant eye?", "option1":"Left","option2":"Right"])
                    
                    self.arrayPersnonID.append("4")
                }
                nextQues()
        }
        
        
    }
    
    
    func setData(value : Int){
        
        
        self.lblYes.text = arrQuestion?[value]["option1"] as? String
        self.lblNo.text = arrQuestion?[value]["option2"] as? String
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        self.lblQuestion.text  = "\(String(describing: strID)) \(String(describing: quename))"
        
        
        
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
        self.lblQuestion.text  = strID! + quename!
        
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
            
          
            
            self.arrayPersnonID.removeAll()
            value = 0
            self.arrayPersnonID.append("1")
            self.arrayPersnonID.append("2")
             self.arrayPersnonID.append("3")
            arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
            
        }
        
  
        
        self.isPreviousClick = true
  
        self.isYesbtnTap = false
    }
    
    
}

