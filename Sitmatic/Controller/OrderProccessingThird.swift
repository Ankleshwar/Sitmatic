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

    @IBOutlet weak var imgCallBanner: UIImageView!
    
    
    @IBOutlet weak var imgConstHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewContainerCall: UIView!
    @IBOutlet weak var viewCallHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imgCallHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imgCallWidth: NSLayoutConstraint!
    
    @IBOutlet weak var btnTryAgain: UIButton!
    
    
    
    @IBOutlet weak var lblModeFinal: UILabel!
    var strValue: String = ""
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    var arrModelDescription : [Model]?
    @IBOutlet weak var btnCancle: UIButton!

    @IBOutlet var viewCall: UIView!
    
    @IBOutlet weak var viewCallTop: UIView!
    @IBOutlet weak var tostView: UIView!
    @IBOutlet weak var tostLable: UILabel!
    
    @IBOutlet weak var viewSubTop: UIView!
    

    @IBOutlet var viewShowModel: UIView!
    var arrIteam :Array<Any>?
    @IBOutlet weak var lblModel: UILabel!
    var dicAnsData = Dictionary<String, String>()
    var dicServerSide = Dictionary<String, Any>()
    var isFirstQue: Bool!
    var Modifie = "0"
    @IBOutlet weak var lblPrice: UILabel!
    var arrQuestion: Array<Dictionary<String,Any>>?
    var arrAnswer = NSMutableArray()
    var arrPreviousControllerData = NSMutableArray()
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    var isYesbtnTap : Bool!
    var isButtonTap = false
    var strSelected : String!
    var dicData = Dictionary<String, String>()
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
    @IBOutlet weak var viewScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnprevious: UIButton!
    var arrayPersnonID: [String] = []
    var customViewAlert: UIView!
    @IBOutlet weak var btnNext: UIButton!
     var isPreviousClick : Bool!
     var serverArrayThid: [[String: String]]  = Array()
     var  value: Int = 0
    
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var viewModel: UIView!
    
    @IBOutlet weak var imgBanner: UIImageView!
    
    @IBOutlet weak var viewCantainsQuestion: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtColor.isHidden = true
       // self.btnTryAgain.layer.cornerRadius = 20.0
        self.btnTryAgain.clipsToBounds = true
        self.setTopView(self.viewTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
           self.setTopView(self.viewCallTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
              self.setTopView(self.viewSubTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
        arrQuestion = setDataWithLocalJson("OrderProccessingThird") as NSArray as? Array<Dictionary<String, Any>>

        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.layer.borderWidth = 0.5
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
//        self.txtAddress.layer.borderWidth = 1
//        self.txtAddress.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8745098039, blue: 0.8745098039, alpha: 1).cgColor
//        self.txtAddress.isEditable = false

        //self.imgBanner.image = UIImage(named: "banner");

        imgBanner.kf.indicatorType = .activity
        let urlbaner = URL(string: imgBaseUrl)
        imgBanner.kf.setImage(with: urlbaner)

        imgCallBanner.kf.indicatorType = .activity
        //let urlbaner = URL(string: imgBaseUrl)
        imgCallBanner.kf.setImage(with: urlbaner)

        if let array = UserDefaults.standard.array(forKey: "SelectedDataThirdScreen") as? [[String:String]] {

            print(array)
            self.serverArrayThid = array
        }

        setInitial()

    }


    @IBAction func clickToBackSub(_ sender: Any) {
        self.viewShowModel.removeFromSuperview()
        self.txtColor.isEnabled = true
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
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        
        UIView().setShadow(self.viewModel)
        UIView().setShadow(self.viewContainerCall)
        UIView().setShadow(self.viewCantainsQuestion)
        UIView().setShadowImg(self.imgBanner)
        UIView().setShadowImg(self.imgCallBanner)

        if device.diagonal == 4{
              self.imgConstHeight.constant = 25.0
            
        }else   if device.diagonal == 4.7{
            
            self.imgConstHeight.constant = 30.0
            self.imgCallWidth.constant = 80.0
            self.imgCallHeight.constant = 80.0
            
        }else   if device.diagonal == 5.5{
           self.imgConstHeight.constant = 35.0
            self.imgCallWidth.constant = 100.0
            self.imgCallHeight.constant = 100.0
            self.viewCallHeight.constant =  220.0
        }
        else {
            
            self.imgConstHeight.constant = 40.0
            self.imgCallWidth.constant = 80.0
            self.imgCallHeight.constant = 80.0
            self.viewCallHeight.constant =  250.0
            
        }


  
        
    }
    
    
    
    
    
    
    
    @objc func donedatePicker(){
        
        self.txtColor.text = strValue
      dicAnsData["id"] = "19"
     dicAnsData["ans"] = strValue

        self.serverArrayThid = self.serverArrayThid.filter { !$0.values.contains(dicAnsData["id"]!) }
        serverArrayThid.append(dicAnsData)
        self.view.endEditing(true)
        textField(color:UIColor.black)

    }
    
    
    
    func setInitial(){
        self.lblYes.text = arrQuestion?[0]["option1"] as? String
        self.lblNo.text = arrQuestion?[0]["option2"] as? String
        //self.lblQuestion.text  = arrQuestion?[0]["queText"] as? String
        
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        //self.lblQuestion.text  = strID + " " + quename
        self.lblQuestion.text  =   quename
        // self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"
        self.arrayPersnonID.append("17")


        var dicdata = [String : String]()

        if serverArrayThid.count > 0{
            let index = serverArrayThid.index(where: {$0["id"] == "18"})

            if index != nil{
                dicdata  = serverArrayThid[index!]
                strSelected = dicdata["ans"]
                if dicdata["ans"] == "No"{
                    self.btnYes.setButtonImage("off.png")
                    self.btnNo.setButtonImage("on.png")
                    self.isYesbtnTap = true
                }else{
                    self.btnYes.setButtonImage("on.png")
                    self.btnNo.setButtonImage("off.png")
                    self.isYesbtnTap = true
                }
            } else{
                self.btnYes.setButtonImage("off.png")
                self.btnNo.setButtonImage("off.png")
            }

        }
        else{
            self.btnYes.setButtonImage("off.png")
            self.btnNo.setButtonImage("off.png")
            self.isYesbtnTap = false
        }




       
        self.btnprevious.isHidden = false
        self.isFirstQue =  true
    }
    
    @IBAction func clickToConfirmModel(_ sender: Any) {
        
        _ = SweetAlert().showAlert("Confirm Evaluation?", subTitle: "", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
              
            }
            else {
                
                    self.callConfirmOrder()
              
              
            }
        }
        
    }
    
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //let strNew : NSString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
      
        let size = CGRectFromString(text)
       
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Please select your address")
        {
            textView.text = ""
            textView.textColor = .black
        }else if (textView.text == "")
        {
            
        }
        
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Please select your address"
            textView.textColor = .lightGray
        }
        
        textView.resignFirstResponder()
    }
    
    
    
    
    
    
    @IBAction func clickToEdit(_ sender: Any) {
//
//        if btnEdit.isSelected {
//
//
////            if self.txtAddress.text == "" {
////                self.showToastForQue(message: "Please select your address", y: 75)
////                self.btnEdit.setButtonImage("check.png")
////
////            }else{
//
//                self.btnEdit.setButtonImage("editblack.png")
//                self.txtAddress.isEditable = false
//
//
//                self.btnEdit.isSelected = false
//
//
//          //  }
//
//
//
//        }else{
//            self.txtAddress.isEditable = true
//
//            self.btnEdit.setButtonImage("check.png")
//
//            self.btnEdit.isSelected = true
//
//        }
    }
    
    @IBAction func clickToPrivious(_ sender: Any) {
        print(value)
        // self.imgBanner.image = UIImage(named: "banner");
        imgBanner.kf.indicatorType = .activity
        let urlbaner = URL(string: imgBaseUrl)
        imgBanner.kf.setImage(with: urlbaner)
        
        if isFirstQue == true {
            self.navigationController?.popViewController(animated: true)
        }
        else{
            if (value == 0){
                print(serverArrayThid)
                UserDefaults.standard.set(serverArrayThid, forKey: "SelectedDataThirdScreen")
                UserDefaults.standard.synchronize()
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)

            }
            else{
                
                

                
                self.arrQuestion?.remove(at: value)
                self.arrayPersnonID.remove(at: value)
                value -= 1
                
                setPreviousData(valueindex: value)
                self.arrAnswer.removeObject(at: value)
                 //serverArrayThid.remove(at: value)
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
    
    
    fileprivate func setdataYes(strId:String) {
        if strId == "17"{
            if let index = self.arrayPersnonID.index(of: "18") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "18","queText": "Please select fabric category", "option1":"Category 2 (Flexx)","option2":"Category 4 (Dreamweave)"])
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
                self.arrQuestion?.append(["queId": "18","queText": "Please select fabric category", "option1":"Category 2 (Flexx)","option2":"Category 4 (Dreamweave)"])
                self.arrayPersnonID.append("18")
            }
//            Timer.scheduledTimer(timeInterval: 0.3,
//                                 target: self,
//                                 selector: #selector(nextQues),
//                                 userInfo: nil,
//                                 repeats: false)
        }
        else if strId == "19"{
            callApi()
        }
            
        else if strId == "18" {
           
            if let index = self.arrayPersnonID.index(of: "19") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "19","queText": "Please select color", "value": ["Flexx Black","Flexx Indigo","Flexx Charcoal","Flexx Burgundy"]])
                self.arrayPersnonID.append("19")
            }
            self.arrIteam = ["Flexx Black","Flexx Indigo","Flexx Charcoal","Flexx Burgundy"]
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
//            Timer.scheduledTimer(timeInterval: 0.3,
//                                 target: self,
//                                 selector: #selector(nextQues),
//                                 userInfo: nil,
//                                 repeats: false)
            
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
            dicAnsData["id"] = strId
            dicAnsData["ans"] = strSelected
            
            
            self.serverArrayThid = self.serverArrayThid.filter { !$0.values.contains(dicAnsData["id"]!) }
           // serverArrayThid.append(dicAnsData)
            
            self.serverArrayThid.append(dicAnsData)
            callApi()
        }else if strId == "19"{
            callApi()
        }
        
        else if strId == "18"{
            
            
            if let index = self.arrayPersnonID.index(of: "19") {
                print(index)
            }
            else{
                self.arrQuestion?.append(["queId": "19","queText": "Please select color", "value": ["Dreamweave Black","Dreamweave Navy","Dreamweave Charcoal","Dreamweave Aqua","Dreamweave Ember","Dreamweave Cologne","Dreamweave Napa","Dreamweave Tropicana"]])
                self.arrayPersnonID.append("19")
            }
             self.arrIteam = ["Dreamweave Black","Dreamweave Navy","Dreamweave Charcoal","Dreamweave Aqua","Dreamweave Ember","Dreamweave Cologne","Dreamweave Napa","Dreamweave Tropicana"]
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
//            Timer.scheduledTimer(timeInterval: 0.3,
//                                 target: self,
//                                 selector: #selector(nextQues),
//                                 userInfo: nil,
//                                 repeats: false)
            
                
            
            
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
        //self.txtColor.layer.cornerRadius = 5.0
    }
    
    
    fileprivate func textFieldSetData() {
        var dicdata = [String : String]()

        if serverArrayThid.count > 0{
            let index = serverArrayThid.index(where: {$0["id"] == "19"})

            if index != nil && isButtonTap == false{
                dicdata  = serverArrayThid[index!]
                self.txtColor.text = dicdata["ans"]
            }else{
                self.txtColor.text = ""
            }

        }else{
             self.txtColor.text = ""
        }
    }

    @IBAction func clickToNext(_ sender: Any) {
        
        
        textField(color:UIColor.black)






        
        if (arrQuestion?[value]["queId"] as? String)! == "19"{
            
            if self.txtColor.text == ""{
                self.showToast(message: " Please select a color ")
                textField(color:UIColor.red)
            }else{
                textField(color:UIColor.black)
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
                 let strUrl  = UserDefaults.standard.string(forKey: "dreamweave")
                    imgBanner.kf.indicatorType = .activity
                    let urlbaner = URL(string: strUrl ?? "")
                    imgBanner.kf.setImage(with: urlbaner)
                   // self.imgBanner.image = UIImage(named: "Dreamweave.png");
                    setDataNo(strId: (arrQuestion?[value]["queId"] as? String)!)
                }
                    
                else{
                    let strUrl  = UserDefaults.standard.string(forKey: "flex")
                    imgBanner.kf.indicatorType = .activity
                    let urlbaner = URL(string: strUrl ?? "")
                    imgBanner.kf.setImage(with: urlbaner)
                    //self.imgBanner.image = UIImage(named: "Flexx.png");
                    setdataYes(strId: (arrQuestion?[value]["queId"] as? String)!)
                }
                
                nextQues()
                self.btnNext.isEnabled = true
            }
            
            
        }
        
        
        
    
     
            
          
        }
        
    @IBAction func clickToTryAgain(_ sender: Any) {
        let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
            
            dicAnsData["id"] = strId
            dicAnsData["ans"] = strSelected
            
            
            
            self.serverArrayThid = self.serverArrayThid.filter { !$0.values.contains(dicAnsData["id"]!) }

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
        self.isButtonTap = true
        self.strSelected = "Yes"
        let strId = arrQuestion?[value]["queId"] as? String
        self.isPreviousClick = false
        
        setdataYes(strId: strId!)
        

        
     
            
        
            
        
            
}
        
    func setNextData(){
        let vc = ModifyModel(nibName: "ModifyModel", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
        
    
    
    
    
    
    func callConfirmOrder(){
        
        let dic = [
            
                   "user_id":(self.appUserObject?.userId)!,
                   "data_id": UserDefaults.standard.string(forKey: "dataId") ?? ""] as [String : Any]
        
        var  strName = (self.appUserObject?.access_token)!
        strName = "sendpdf?token=\(strName)"
        
        SVProgressHUD.show()
        
        ServiceClass().getModel(strUrl: strName, param: dic as [String : AnyObject] ) { error, jsondata in
            
            if error != nil{
                
                
                self.showToast(message: (error?.localizedDescription)!)
        
                SVProgressHUD.dismiss()
            }else{
                
               print(jsondata)
                
                let dataDic =  jsondata["successData"]
                let orderId = dataDic["order_number"]
                
                _ = SweetAlert().showAlert("We’re done!", subTitle: "Check your inbox. Your evaluation ID is  \(String(describing: orderId))", style: AlertStyle.success)
                let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
        
        
    
    
    
    @objc func callApi(){
        
       // self.btnprevious.isHidden =  true
         self.btnprevious.isEnabled = false
        self.btnNext.isEnabled = false
        self.btnCancle.isEnabled = false
        //serverArrayThid.append(dicServerSide)
        
        print(serverArrayThid)
        
        
        
        
        
        let strJson = self.json(from: serverArrayThid)
        print(strJson ?? "")
        
        self.callGenrateModelApi(strData :strJson!)
        
    }
    
    

    
    
    
    
    
    
    func callGenrateModelApi(strData : String){
        let array = NSMutableArray()
        array.add(dicServerSide)
        let strJson = self.json(from: array)
        print(strJson ?? "")
        
        
        //print(strJson)
        let dic = ["questions": strData,
                   "isModify": Modifie,
                   "data": strJson,
                   "data_id": UserDefaults.standard.string(forKey: "dataId") ?? ""] as [String : Any]

        self.txtColor.isEnabled = false
        var  strName = (self.appUserObject?.access_token)!
        strName = "getmodifiedmodel?token=\(strName)"
        
        print(dic)
        SVProgressHUD.show()
        
        ServiceClass().getModel(strUrl: strName, param: dic as [String : AnyObject] ) { error, jsondata in
            
            if error != nil{
             
                
                self.showToast(message: (error?.localizedDescription)!)
                self.btnCancle.isEnabled = true
                self.btnNext.isEnabled = true
                self.txtColor.isEnabled = true
                self.btnprevious.isEnabled = true
                SVProgressHUD.dismiss()
            }else{
                
//                if let navVCsCount = self.navigationController?.viewControllers.count {
//                    self.navigationController?.viewControllers.removeSubrange(Range(0..<navVCsCount - 1))
//                }

                self.btnCancle.isEnabled = true
                self.btnNext.isEnabled = true
                self.txtColor.isEnabled = true
                self.btnprevious.isEnabled = true

                if jsondata["callDetected"] == "Yes"{
                    
                    self.viewCall.frame = self.view.bounds
                    self.view.addSubview(self.viewCall)
                    
                }
                else{
                    
                  
                    
                    let obj = SuccessData(fromJson: jsondata["successData"])
                    self.arrModelDescription = obj.model
                   
      
                    
            
                    
            
                    
                    
                    self.isYesbtnTap = false
                   
                    
                    self.addSubView(obj)
                    
                }
            }
            
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    
    fileprivate func addSubView(_ obj: SuccessData) {
    
        self.viewShowModel.frame = self.view.bounds
        self.view.addSubview(self.viewShowModel)
        
        
        self.tableViewHieght.constant = CGFloat((self.arrModelDescription?.count)! * 70 + 10 + 50)
//self.tableViewHieght.constant = CGFloat(6 * 50 + 20)
        let modelName = UIDevice.modelName
          let frame = self.lblPrice.frame.origin.y+self.lblPrice.frame.height+50
        if modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone 5" || modelName == "iPhone SE" {
           
             self.viewScrollHeight.constant =   CGFloat((self.arrModelDescription?.count)! * 70 + 10 + 70) + CGFloat(frame) +  CGFloat(20)
        }
        else{
         //   self.viewScrollHeight.constant =  CGFloat((self.arrModelDescription?.count)! * 50 )
            
             self.viewScrollHeight.constant =   CGFloat((self.arrModelDescription?.count)! * 70 + 10 + 50) + CGFloat(frame) 
        }
        
        //self.tableViewieght.constant = 3 * 50 + 20
        
        
      
        
        let attrs1 = [NSAttributedStringKey.font : UIFont(name: "Roboto-Light", size: 19) ?? "", NSAttributedStringKey.foregroundColor :#colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)] as [NSAttributedStringKey : Any]
        
     
        
        let attributedString1 = NSMutableAttributedString(string:"We’re all done! Your ideal chair model is:", attributes:attrs1)
        
 
        
      
        self.lblModel.attributedText = attributedString1
        self.lblModeFinal.text = obj.proposedModel
      
        
       // self.lblPrice.text = "Total Price:" + " " + "$" + String(obj.proposedPrice)
        self.lblPrice.text = "List Price:" + " " + "$" + String(obj.proposedPrice)
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
        
//        if    (self.appUserObject?.address)! == "" {
//            self.txtAddress.text = "Please select your address"
//        }
//        else{
//            self.txtAddress.text = (self.appUserObject?.address)!
//        }
//
      
    }
    
    
    
    
    
    @objc func rightButtonClicked(_ sender: Any) {
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    @IBAction func clickToBtnNo(_ sender: Any) {
        self.btnNext.isEnabled = true
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("on.png")
        self.isYesbtnTap = true
        self.isPreviousClick = false
        self.strSelected = "No"
        self.isButtonTap = true
        let strId = arrQuestion?[value]["queId"] as? String
        
         setDataNo(strId: strId!)

        
        
    }
    
    
    func setData(value : Int){
        
        
        self.lblYes.text = arrQuestion?[value]["option1"] as? String
        self.lblNo.text = arrQuestion?[value]["option2"] as? String
        _ = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        
        
        
        
        self.lblQuestion.text  =   quename
        
       // self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
        
        
        if (arrQuestion?[value]["queId"] as? String)! == "19"{
            textFieldSetData()
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
           textFieldSetData()
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
       // self.lblQuestionValueCount.text = strID! + " " + "of 19 Questions"
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



extension OrderProccessingThird:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return (arrModelDescription?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell
        
        
        if self.arrModelDescription![indexPath.section].descriptionField != nil {
             cell?.lblDiscription?.text = " " + self.arrModelDescription![indexPath.section].descriptionField
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return 110.0
        }else{
            return 70.0
        }
    }
}



extension OrderProccessingThird: UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(5)
        self.pickerView.reloadAllComponents()
        if device.diagonal == 4{
            self.moveTextField(textField: textField, moveDistance: -150, up: true)
            
        }else   if device.diagonal == 4.7{
            self.moveTextField(textField: textField, moveDistance: -150, up: true)
            
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if device.diagonal == 4{
            self.moveTextField(textField: textField, moveDistance: -150, up: false)
            
        }else   if device.diagonal == 4.7{
            self.moveTextField(textField: textField, moveDistance: -150, up: false)
            
        }
        
    }
    
}

