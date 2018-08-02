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


protocol OrderProccessingSecondDelegate  {
    func setData(arrData:[[String: String]],isbackValue:Bool)
}



class OrderProccessingSecond: BaseViewController , ModifyModelDelegate{
    
    
    
    
    var sucessObj : SuccessData!
    var strValueID = ""
    var strprice = ""
    @IBOutlet weak var lblModelCode: UILabel!
    @IBOutlet var viewCall: UIView!
    
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet var viewSubView: UIView!
    @IBOutlet weak var tostView: UIView!
    @IBOutlet weak var tostLable: UILabel!
    @IBOutlet weak var btnCancle: UIButton!
    @IBOutlet weak var btnPreviousSub: UIButton!
    @IBOutlet weak var tableViewieght: NSLayoutConstraint!
    @IBOutlet weak var viewScrollHeight: NSLayoutConstraint!
    var dicPreviousData = Dictionary<String, Any>()
    @IBOutlet weak var txtModelNumber: UITextField!
    
    var delegate : OrderProccessingSecondDelegate?
    var dicAnsData = Dictionary<String, String>()
    var isFirstQue: Bool!

    @IBOutlet weak var tableView: UITableView!
    var arrQuestion: Array<Dictionary<String,Any>>?
    var arrAnswer = NSMutableArray()
    
    @IBOutlet weak var btnYesSub: UIButton!
    
    @IBOutlet weak var btnNoSub: UIButton!
    var arrPreviousControllerData: [[String: String]]  = Array()
    var arrModelDescription : [Model]?
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

    @IBOutlet weak var viewModel: UIView!
    
    
    
    
    @IBOutlet weak var lblQuestionValueCount: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrQuestion = setDataWithLocalJson("OrderProccessingSecond") as NSArray as? Array<Dictionary<String, Any>>
        setInitial()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
       // tableView.estimatedRowHeight = 45
      //  tableView.rowHeight = UITableViewAutomaticDimension
        
//        self.setShadow(self.viewDetails)
//        self.setShadow(self.viewModel)
    }
    
    func setShadow(_ view: UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        
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
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
     
        
        //self.arrayPersnonID.append("13")
    
        //self.btnprevious.isHidden = true
        self.isFirstQue =  true
    }
    
    func setDataOnPrevious(dicValue: [String : Any]) {
        self.dicPreviousData = dicValue
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickToPrivious(_ sender: Any) {
        print(value)
        
        
        if isFirstQue == true {
            self.delegate?.setData(arrData: arrPreviousControllerData,isbackValue: true)
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
                //self.arrayPersnonID.remove(at: value)
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
           
            self.showToast(message: " Please select a valid option  ")
            
            if strValueID == "15"{
                self.btnNoSub.setButtonImage("red.png")
                self.btnYesSub.setButtonImage("red.png")
                
            }else{
                self.btnYes.setButtonImage("red.png")
                self.btnNo.setButtonImage("red.png")
            }
            
         
        }
        else{
            
           
            
            if strValueID == "15" {
                if strSelected == "No"{
                    self.setNoNextScreen()
                }else{
                    self.setNextData()
                }

            }else{
                 nextQues()
            }
            
           
            
        }
        
    }
    
    
    fileprivate func serverSideData() {
        let strId = arrQuestion?[value]["queId"] as! String
        self.serverArrayThid = self.serverArrayThid.filter { !$0.values.contains(strId) }
        dicAnsData["id"] = arrQuestion?[value]["queId"] as? String
        dicAnsData["ans"] = strSelected
        self.serverArrayThid.append(dicAnsData)
    }
    
    @objc func nextQues(){
        
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
            if arrQuestion?[value]["queId"] as? String == "14" {
                  self.btnprevious.isHidden = true
                
            }else{
                  self.btnprevious.isHidden = false
            }
            
          
            
            serverSideData()
            
            
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
        
        if strId == "14"{
            serverSideData()
            callApi()
        }else{
            
            
            self.view.isUserInteractionEnabled = false
            Timer.scheduledTimer(timeInterval: 0.5,
                                 target: self,
                                 selector: #selector(self.nextQues),
                                 userInfo: nil,
                                 repeats: false)
            
        }
     
             
            
            
        
            
}
        
    @objc func setNextData(){
        self.view.isUserInteractionEnabled = true
        let vc = ModifyModel(nibName: "ModifyModel", bundle: nil)
        vc.delegate = self
        vc.dicSelected = self.dicPreviousData
        vc.successDataObject = self.sucessObj
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
        
        
        
        
    
    
    
    func callApi(){
        
     
        self.btnprevious.isHidden =  true
        self.btnNext.isEnabled = false
        self.btnCancle.isEnabled = false
        
        print(serverArrayThid)
        
        let strJson = self.json(from: serverArrayThid)
        print(strJson ?? "")
        
        self.callGenrateModelApi(strData :strJson!)
        self.btnprevious.isHidden =  true
    }
    
    

    
    
    
    
    
    
    fileprivate func addSubView(_ obj: SuccessData) {
        self.viewSubView.frame = self.view.bounds
        self.view.addSubview(self.viewSubView)
        
        
         self.tableViewieght.constant = CGFloat((self.arrModelDescription?.count)! * 50 + 20 + 50)
        let modelName = UIDevice.modelName
        
        if modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone 5" || modelName == "iPhone SE" {
            self.viewScrollHeight.constant = CGFloat((self.arrModelDescription?.count)! * 50 + 80)
        }
        else{
            self.viewScrollHeight.constant =  CGFloat((self.arrModelDescription?.count)! * 50 )
        }
        
        //self.tableViewieght.constant = 3 * 50 + 20
        
//        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "Roboto-Light", size: 19) ?? "", NSAttributedStringKey.foregroundColor :#colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)] as [NSAttributedStringKey : Any]
//
//        let attrs2 = [NSAttributedStringKey.font : UIFont(name: "Roboto-Bold", size: 22) ?? "", NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.1215686275, green: 0.5607843137, blue: 0.7843137255, alpha: 1)] as [NSAttributedStringKey : Any]
//
//        let attributedString1 = NSMutableAttributedString(string:"Your ideal chair model is ", attributes:attrs1)
//
//        let attributedString2 = NSMutableAttributedString(string:obj.proposedModel, attributes:attrs2)
//
//        attributedString1.append(attributedString2)
        self.lblModel.text = "We're almost done!" +  " "  + "Your ideal chair model is "
        self.lblModelCode.text = obj.proposedModel
        //self.lblprice.text = obj.proposedPrice
        self.lblprice.text = "Total Price:" + " " + "$" + String(obj.proposedPrice)
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
        self.btnNext.isHidden = true
        self.btnCancle.isEnabled = true
        let sendData = obj
        
        
    }
    
    func callGenrateModelApi(strData : String){
        
        let dic = ["data": strData,
                   "user_id":(self.appUserObject?.userId)!]

        
        
        SVProgressHUD.show()
        
        ServiceClass().getModel(strUrl: "savebasicquestions", param: dic as [String : AnyObject] ) { error, jsondata in
            
            if error != nil{
                
                self.showToast(message: (error?.localizedDescription)!)
                self.btnCancle.isEnabled = true
                
                SVProgressHUD.dismiss()
           
            }
            else{
                if let navVCsCount = self.navigationController?.viewControllers.count {
                    self.navigationController?.viewControllers.removeSubrange(Range(0..<navVCsCount - 1))
                }
                
                if jsondata["callDetected"] == "Yes"{

                    self.viewCall.frame = self.view.bounds
                    self.view.addSubview(self.viewCall)

                }
                else{
                    
                  //  print(self.navigationController?.viewControllers.count)
                    
                  
                    
                    let obj = SuccessData(fromJson: jsondata["successData"])
                    self.arrModelDescription = obj.model
                    self.sucessObj = obj
        
                    let objNew = ModelDescreption(fromJson: jsondata)
                
               
                let strDataId = String(objNew.dataId)
         
                UserDefaults.standard.set(strDataId, forKey: "dataId")
                UserDefaults.standard.synchronize()
              
                    self.btnYesSub.setButtonImage("off.png")
                    self.btnNoSub.setButtonImage("off.png")
                    
               
                    self.isYesbtnTap = false
                    self.strValueID = "15"
                    
                    self.addSubView(obj)
                    
                }
            }
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    // MARK:- SubView Actions
    
    @IBAction func clickToYesSub(_ sender: Any) {
       
        self.isYesbtnTap = true
        self.btnYesSub.setButtonImage("on.png")
        self.btnNoSub.setButtonImage("off.png")
         self.strSelected = "Yes"
        self.view.isUserInteractionEnabled = false
        self.btnNext.isEnabled = true
        Timer.scheduledTimer(timeInterval: 0.5,
                             target: self,
                             selector: #selector(self.setNextData),
                             userInfo: nil,
                             repeats: false)
        dicAnsData["isModified"] = "1"
     
        print(UserDefaults.standard.string(forKey: "dataId") ?? "")
    }
    
    
    
    @IBAction func clickToNoSub(_ sender: Any) {
        self.isYesbtnTap = true
        self.btnNoSub.setButtonImage("on.png")
        self.btnYesSub.setButtonImage("off.png")
        self.strSelected = "No"
        Timer.scheduledTimer(timeInterval: 0.3,
                             target: self,
                             selector: #selector(self.setNoNextScreen),
                             userInfo: nil,
                             repeats: false)
         dicAnsData["isModified"] = "0"
        
    }
    
    
    
    @IBAction func clickToCallDone(_ sender: Any) {
        let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    
    @IBAction func clickToBtnNo(_ sender: Any) {
        self.btnNext.isEnabled = true
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("on.png")
        self.isYesbtnTap = true
        self.isPreviousClick = false
        self.strSelected = "No"
        let strId = arrQuestion?[value]["queId"] as? String
        
        
        if strId == "14"{
            serverSideData()
            callApi()
        }
        else{
            Timer.scheduledTimer(timeInterval: 0.3,
                                 target: self,
                                 selector: #selector(nextQues),
                                 userInfo: nil,
                                 repeats: false)
        }
        
        
    }
    
  @objc  func setNoNextScreen(){
       let vc = OrderProccessingThird(nibName: "OrderProccessingThird", bundle: nil)
        vc.Modifie = "0"
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.view.isUserInteractionEnabled = true
    }
    
    func setPreviousData(valueindex : Int){
        
        
        
        
        var dicdata  = arrAnswer[valueindex] as! [String: String]
        
        self.lblYes.text = dicdata["option1"]
        self.lblNo.text = dicdata["option2"]
        let strID = dicdata["queId"]
        let quename = dicdata["queText"]
        //self.lblQuestion.text  = strID! + " " + quename!
        self.lblQuestion.text  =   quename!
        self.lblQuestionValueCount.text = strID! + " " + "of 19 Questions"
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
           // self.arrayPersnonID.removeAll()
            value = 0
          //  self.arrayPersnonID.append("13")
         
            arrQuestion = setDataWithLocalJson("OrderProccessingSecond") as NSArray as? Array<Dictionary<String, Any>>
            
        }
        
        
        
        self.isPreviousClick = true
        
        self.isYesbtnTap = true
    }
    
    
}


extension OrderProccessingSecond:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (arrModelDescription?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
         return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell
        
        
        
        if self.arrModelDescription![indexPath.section].descriptionField != nil {
            cell?.lblDiscription?.text =  self.arrModelDescription![indexPath.section].descriptionField
        }
        if self.arrModelDescription![indexPath.section].type != nil {
            cell?.lblTittle.text = self.arrModelDescription![indexPath.section].type
        }
        
        

       
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        }else{
             return 2.0
        }
       
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 2))
        viewHeader.backgroundColor = UIColor.white
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 2{
            return 100.0
        }else{
            return 50.0
        }
        
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
