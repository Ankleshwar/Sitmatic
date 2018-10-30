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
import MediaPlayer
import AVKit
import AVFoundation

protocol OrderProccessingNewDelegate  {
    func setData(arrData:[[String: String]],isbackValue:Bool)
}



class OrderProccessingNew: BaseViewController , ModifyModelDelegate{
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgConstraintTopHeight: NSLayoutConstraint!
    @IBOutlet weak var btnVideoConstraintTopHeight: NSLayoutConstraint!
    @IBOutlet weak var viewSubTop: UIView!
    
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet var pickerView: UIPickerView!
    var delegateNew :OrderProccessingNewDelegate?
   lazy var strServerData = String()
     var strValue: String!
   lazy var strError = String()
 lazy   var isImageDataEmpty = false
   lazy var strImgeUrl = String()
   lazy  var strVideoUrl = String()
    var arrImage = NSMutableArray()
    var arrIteam :Array<Any>?
    @IBOutlet weak var viewQuestion: UIView!
    
    @IBOutlet weak var viewHeightSecond: NSLayoutConstraint!
    
    @IBOutlet weak var viewCallTop: UIView!
    @IBOutlet weak var imgBanner: UIImageView!
    var strImgeUrlbanner = String()
    var sucessObj : SuccessData!
    var strValueID = ""
    var strprice = ""
    @IBOutlet weak var lblModelCode: UILabel!
    @IBOutlet var viewCall: UIView!
   var questionsArray : [Question]!
    
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet var viewSubView: UIView!

    @IBOutlet weak var btnCancle: UIButton!
    
    @IBOutlet weak var tableViewieght: NSLayoutConstraint!
    @IBOutlet weak var viewScrollHeight: NSLayoutConstraint!
    var dicPreviousData = Dictionary<String, Any>()
    
    @IBOutlet weak var txtField: UITextField!
    
    var delegate : OrderProccessingSecondDelegate?
    var dicAnsData = Dictionary<String, String>()
    var isFirstQue: Bool!
    var strArme = String()
    @IBOutlet weak var tableView: UITableView!
    var arrQuestion: Array<Dictionary<String,Any>>?
    var arrAnswer = NSMutableArray()
    
    @IBOutlet weak var btnYesSub: UIButton!
    
    @IBOutlet weak var btnNoSub: UIButton!
    var arrPreviousControllerData: [[String: String]]  = Array()
    var arrModelDescription : [Model]?
 
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
 
    
    
    

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTopView(self.viewTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
        
          self.setTopView(self.viewSubTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
          self.setTopView(self.viewCallTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
        print(strServerData)
        
        arrQuestion = setDataWithLocalJson("OrderProccessingNew") as NSArray as? Array<Dictionary<String, Any>>
        setInitial()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.layer.borderWidth = 0.5
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
         self.setImageUrl()
        
      
    }
    
    
    override func viewDidLayoutSubviews() {
        
        UIView().setShadowImg(self.imgBanner)
        
        UIView().setShadow(self.viewContainer)
        
      
        
    }
    
    @objc func rightButtonClicked(_ sender: Any) {
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setShadow(_ view: UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        
    }
    
    
    func setInitial(){

        lblQuestion.text = arrQuestion?[0]["questionText"] as? String
        self.arrIteam = arrQuestion?[0]["value"] as? Array
    
       
    }
    
    func setDataOnPrevious(dicValue: [String : Any]) {
        self.dicPreviousData = dicValue
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickToPrivious(_ sender: Any) {
       
         textField(color:UIColor.white)
        self.delegateNew?.setData(arrData: [[:]], isbackValue: true)
        self.navigationController?.popViewController(animated: true)
            
        
     
        
        
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
      //  self.tostView.makeToast(" Please select a valid option for start order   ", duration: 2.0, position: .top, style: style )

        
    }
    
    
    @IBAction func clickToCancel(_ sender: Any) {
       
        
        
        _ = SweetAlert().showAlert("Cancel Evaluation?", subTitle: "Are you sure you want to cancel?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
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
    fileprivate func textField(color:UIColor) {
        self.txtField.layer.borderWidth = 1.0
        self.txtField.layer.borderColor = color.cgColor
        //self.txtField.layer.cornerRadius = 5.0
    }
    
    
    @objc func donedatePicker(){
        

            self.txtField.text = strValue
            textField(color:UIColor.lightGray)
            self.view.endEditing(true)
        
        }

    
    override func viewWillAppear(_ animated: Bool) {
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        showPicker()
       
        print("viewWillAppearCall")
    }
    
    func showPicker(){
        
        self.txtField.inputView = self.pickerView
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtField.inputAccessoryView = toolBar
        
        
    }
    
    
    
    
    
    
    @IBAction func clickToNext(_ sender: Any) {
        
    
        if self.txtField.text?.count == 0 {
            
            
            self.showToast(message: "Please select a valid option")
            textField(color:UIColor.red)
            
            
        }
        else{
             textField(color:UIColor.white)
        //    self.btnGallery.isHidden = true
             self.btnVideo.isHidden = true
            dicAnsData["id"] = "16"
            dicAnsData["ans"] = self.txtField.text
            self.serverArrayThid.append(dicAnsData)
                callApi()
            
      
           
            
        }
        
    }
    
    
    fileprivate func serverSideData() {
        let strId = arrQuestion?[value]["queId"] as! String
        self.serverArrayThid = self.serverArrayThid.filter { !$0.values.contains(strId) }
        dicAnsData["id"] = arrQuestion?[value]["queId"] as? String
        dicAnsData["ans"] = strSelected
        self.serverArrayThid.append(dicAnsData)
    }
    
   
    
    
    
    
    
    @objc func setNextData(){
        self.view.isUserInteractionEnabled = true
        let vc = ModifyModel(nibName: "ModifyModel", bundle: nil)
        vc.delegate = self
        vc.dicSelected = self.dicPreviousData
        vc.arrQuesOfModifiy = self.questionsArray
        vc.successDataObject = self.sucessObj
        vc.strArmrest =  self.strArme
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
    func setImageUrl(){
      
        imgBanner.kf.indicatorType = .activity
        let urlBanner = URL(string: strImgeUrlbanner)
        imgBanner.kf.setImage(with: urlBanner)
        
        
       
        
        
    }
    
    

    @IBAction func clickToSuggest(_ sender: Any) {
        if isImageDataEmpty == true{
            self.showToast(message: strError)
        }else{
            
            
            
            
            if (sender as AnyObject).tag == 1 {
                
                self.setImageUrl()
                
               
            }
            else if (sender as AnyObject).tag == 3 {
               
              
                
                let videoURL = URL(string: strVideoUrl)
                let playerItem = CachingPlayerItem(url: videoURL!)
                let player = AVPlayer(playerItem: playerItem)
                player.automaticallyWaitsToMinimizeStalling = true
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                
                self.present(playerViewController, animated: true) {
                    
                    playerViewController.player!.play()
                    
                    
                }
                
            }
            else {
                
                
            }
        }
    }
    
    
    
    
    
    
    
    
    fileprivate func addSubView(_ obj: SuccessData) {
        self.viewSubView.frame = self.view.bounds
        self.view.addSubview(self.viewSubView)
        
        
        self.tableViewieght.constant = CGFloat((self.arrModelDescription?.count)! * 50 + 5 + 50)
        let modelName = UIDevice.modelName
          let frame = self.viewQuestion.frame.origin.y+self.viewQuestion.frame.height+20
        if modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone 5" || modelName == "iPhone SE" {
            self.viewScrollHeight.constant = CGFloat((self.arrModelDescription?.count)! * 50 + 410)
        }
        else{
             self.viewScrollHeight.constant =   CGFloat((self.arrModelDescription?.count)! * 50) + CGFloat(frame)
        }
        

        self.lblModel.text = "We're almost done! So far," +  " "  + "your ideal chair model is:"
        self.lblModelCode.text = obj.proposedModel
        //self.lblprice.text = obj.proposedPrice
        self.lblprice.text = "List Price:" + " " + "$" + String(obj.proposedPrice)
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
        self.btnNext.isHidden = true
        self.btnCancle.isEnabled = true
        _ = obj
        
        
    }
    
    func callGenrateModelApi(strData : String){
        
        let dic = ["data": strData,
                   "user_id":(self.appUserObject?.userId)!,
                   "name": (self.appUserObject?.lastName)!,
                   "organization_name": self.appUserObject?.countryCode ?? "",
        ]

        print(dic)
        var  strName = (self.appUserObject?.access_token)!
        strName = "savebasicquestions?token=\(strName)"
        
        SVProgressHUD.show()

        

        ServiceClass().getModel(strUrl: strName, param: dic as [String : AnyObject] ) { error, jsondata in
            
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
                    
                    let objMain = ModelDescreption(fromJson: jsondata)
                    print(objMain.questions.count)
                    
                    self.questionsArray = objMain.questions
                    self.strArme = objMain.armrestDetected
                    
             
              
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
    
    
    
    
    
    
    

    
  @objc  func setNoNextScreen(){
       let vc = OrderProccessingThird(nibName: "OrderProccessingThird", bundle: nil)
        vc.Modifie = "0"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    
   
    
}


extension OrderProccessingNew:UITableViewDelegate,UITableViewDataSource{
    
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


extension OrderProccessingNew : UIPickerViewDelegate,UIPickerViewDataSource{
    
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
        
        
       
            self.strValue = arrIteam?[row] as? String
        
        
        
    }
}

extension OrderProccessingNew: UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
  
        
       
        
            let countSize = (self.arrIteam?.count)!/2
            self.pickerView.selectRow(countSize, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: countSize, inComponent: 0)

        
        textField.setLeftPaddingPoints(5)
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
