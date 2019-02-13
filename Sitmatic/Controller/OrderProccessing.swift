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
import Kingfisher
import MediaPlayer
import AVKit
import AVFoundation

protocol OrderProccessingDelegate {
    func setData(arrData:[[String: String]])
}


class OrderProccessing: BaseViewController , StartOrderdDelegate {
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var btnVideo: UIButton!
    var strError = String()
    @IBOutlet weak var btnCancleSuggetion: UIButton!
   
    @IBOutlet weak var imgConstraintTopHeight: NSLayoutConstraint!
    var arrImage = NSMutableArray()
    var delegate:OrderProccessingDelegate?
    @IBOutlet weak var tostView: UIView!
    @IBOutlet weak var tostLable: UILabel!
    var arrCurrent: [[String: String]]  = Array()
    
    @IBOutlet weak var btnVideoConstraintTopHeight: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnSuggestion: UIButton!
    var isback = false
    var strName: String!
    var strOrganization: String!
    @IBOutlet weak var tableView: UITableView!
    var arrQuestion: Array<Dictionary<String,Any>>?
    var arrAnswer: [[String: String]]  = Array()
    var arrStartOrderData: [[String: String]]  = Array()
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblYes: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    var isYesbtnTap : Bool!
    var strSelected : String!
    var dicData = Dictionary<String, String>()
    @IBOutlet weak var lblNo: UILabel!
    var arrNext = [[:]]
    var dicNext  = Dictionary<String, Any>()
    @IBOutlet weak var btnprevious: UIButton!
    var arrayPersnonID: [String] = []
    var customViewAlert: UIView!
    @IBOutlet weak var btnNext: UIButton!
    var isPreviousClick : Bool!
     var dicAnsData = Dictionary<String, String>()

    var serverArray: [[String: String]]  = Array()
    var isImageDataEmpty = false
    
   
    @IBOutlet weak var imgSuggestion: UIImageView!
    var  value: Int = 0
    
   // @IBOutlet weak var lblQuestionValueCount: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>

     
             setInitial()
        
        self.setTopView(self.viewTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user-icon26x26.png", withoutBackButton: true)

        
        self.callGenrateModelApi()
        
    }
    override func viewDidLayoutSubviews() {
       
         UIView().setShadowImg(self.imgBanner)
        
         UIView().setShadow(self.viewContainer)
        
        if device.diagonal == 4{
           self.btnVideoConstraintTopHeight.constant = 35.0
            self.imgConstraintTopHeight.constant = 25.0
        }else   if device.diagonal == 4.7{
            
            self.imgConstraintTopHeight.constant = 30.0
             self.btnVideoConstraintTopHeight.constant = 40.0
        }else   if device.diagonal == 5.5{
            self.imgConstraintTopHeight.constant = 35.0
             self.btnVideoConstraintTopHeight.constant = 45.0
        }
        else {
           
            self.imgConstraintTopHeight.constant = 40.0
             self.btnVideoConstraintTopHeight.constant = 50.0
           
        }
  
    }
    
    
    @objc func rightButtonClicked(_ sender: Any) {
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func callGenrateModelApi(){
        
          self.view.isUserInteractionEnabled = false
        
        SVProgressHUD.show()
        var  strName = (self.appUserObject?.access_token)!
        strName = "resources?token=\(strName)"
        ServiceClass().HomeScreenData(strUrl: strName, param: [:] ) { error, jsondata in
            
            if error != nil{
                
                self.showToast(message: (error?.localizedDescription)!)
                self.strError = (error?.localizedDescription)!
                self.isImageDataEmpty = true
                SVProgressHUD.dismiss()
                self.btnNext.isEnabled = false
                
            }
            else{
                self.btnNext.isEnabled = true
                self.isImageDataEmpty = false
                ////print(jsondata)
                self.arrImage.add(jsondata)
                self.setImageUrl(str:(self.arrQuestion?[self.value]["queId"] as? String)! )
          
            }
            SVProgressHUD.dismiss()
              self.view.isUserInteractionEnabled = true
        }
        
        
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
        
        self.btnprevious.isHidden = false
    }
    
    
    @IBAction func clickToSuggest(_ sender: Any) {
        if isImageDataEmpty == true{
             self.showToast(message: strError)
        }else{
            
        
        
        
        if (sender as AnyObject).tag == 1 {
      
            self.setImageUrl(str:(arrQuestion?[value]["queId"] as? String)! )

            
            }
        else if (sender as AnyObject).tag == 3 {
            let Array = arrImage[0] as! [HomeData]
            var strUrl = String()
            if (arrQuestion?[value]["queId"] as? String)! == "1"{
               strUrl = Array[0].video
                
            }else if (arrQuestion?[value]["queId"] as? String)! == "2"{
                strUrl = Array[1].video
              
               
            }else if (arrQuestion?[value]["queId"] as? String)! == "3" || (arrQuestion?[value]["queId"] as? String)! == "5Y"{
               strUrl = Array[3].video
               
            }
            
                    let videoURL = URL(string: strUrl)
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
//            self.viewSub.removeFromSuperview()
//
//            if let viewWithTag = self.view.viewWithTag(500) {
//
//                viewWithTag.removeFromSuperview()
//            }
          
        }
        }
}
    
    
    @IBAction func clickToCancel(_ sender: Any) {
        
        
        
        _ = SweetAlert().showAlert("Cancel Evaluation?", subTitle: "Are you sure you want to cancel?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                
            }
            else {
                
                let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    func setDataOnBack(isBack: Bool , arrSaveValue: [[String : String]]) {
        self.isback = isBack
        self.btnNext.isEnabled = true
        self.arrStartOrderData = arrSaveValue
       let strId = (arrQuestion?[value]["queId"] as? String)!
        if strId == "5Y"{
            self.btnVideo.isHidden = true
        }
        
    }
    
    
    
    @IBAction func clickToNext(_ sender: Any) {
        
        
        if self.isYesbtnTap == false  {
            self.showToast(message: "Please select a valid option")
            self.btnYes.setButtonImage("red.png")
            self.btnNo.setButtonImage("red.png")
           
        } else if isback == true{
            goToNext()
            self.isback = false
            
        }
        else{
            
           ////print(strSelected)
            
            self.setNextButtonData(strId: (arrQuestion?[value]["queId"] as? String)!)
            self.setImageUrl(str:(self.arrQuestion?[self.value]["queId"] as? String)! )
           
           }
        
        
    }
    
    
    func setNextButtonData(strId:String){
        
      
        
        if strSelected == "No" {
          
            
                self.btnVideo.isHidden = false
            
            
            
            
            if self.isPreviousClick == false {
                 dataForNo(strId)
                if strId == "5Y"{
                    goToNext()
                }
                    
                else if strId == "3"{
                    goToNext()
                }else{
                    TimeInterval()
                }
                
                
            }
            else{
                 dataForNo(strId)
                if strId == "5Y"{
                    goToNext()
                }
                    
                else if strId == "3"{
                    goToNext()
                }
                
            }
            
           
            
            
        }
        else{
            
            if strId == "2" || strId == "3Y" || strId == "4Y"{
               
                self.btnVideo.isHidden = true
            }else{
              
                self.btnVideo.isHidden = false
            }
            
            if self.isPreviousClick == false {
               dataForYes(strId)
                if strId == "5Y"{
                    goToNext()
                }
                    
                else if strId == "3"{
                    goToNext()
                }else{
                    TimeInterval()
                }
            }else{
                dataForYes(strId)
                if strId == "5Y"{
                    goToNext()
                }
                    
                else if strId == "3"{
                    goToNext()
                }
                
            }
            
            
            
        }
        
    }
    
    //MARK: set Data No Button
    
    
    
    @IBAction func clickToBtnNo(_ sender: Any) {
        //  self.btnNext.isEnabled = false
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("on.png")
        self.isYesbtnTap = true
        self.isPreviousClick = false
        strSelected = "No"
         self.arrStartOrderData =  Array()
        let strId = arrQuestion?[value]["queId"] as? String
      //  dataForNo(strId!)
        
        
        
        
    }
    
    
    
    
    fileprivate func TimeInterval() {
        self.view.isUserInteractionEnabled = false
        self.nextQues()
    }
    
    fileprivate func nextIndexData(_ index: Array<Any>.Index?, _ dicLocal: inout [String : String]) {
        if index != nil{
            dicLocal  = arrCurrent[index!]
           
          
            self.arrAnswer = self.arrAnswer.filter { !$0.values.contains(dicLocal["queId"]!) }
            self.arrAnswer.append(dicLocal)
            let strId = dicLocal["queId"]
            dicAnsData["id"] = dicLocal["queId"]
            dicAnsData["ans"] = dicLocal["selected"]
            self.serverArray = self.serverArray.filter { !$0.values.contains(strId!) }
            self.serverArray.append(dicAnsData)
            self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(dicLocal["queId"]!)}
            self.arrCurrent.append(dicLocal)



        }else{
            self.value -= 1
            TimeInterval()
        }
    }
    
    fileprivate func dataForNo(_ strId: String) {
        if strId == "3"{
            serverSideData()
            
          //  goToNext()
        }
        else if strId == "5Y"{
            serverSideData()
            
            
           // goToNext()
        }
        else{
            
            if strId == "2" || strId == "3Y" || strId == "4Y"{
            
                if let index = self.arrayPersnonID.index(of: "3") {
                    ////print(index)
                    
                }
                    
                else{
                    self.arrQuestion?.append(["queId": "3","queText": "Which is your dominant eye?", "option1":"Left","option2":"Right"])
                    
                    self.arrayPersnonID.append("3")
                }
                
                
            }
            
            
            //nextQues()
            
            if isPreviousClick == true{
                
               value += 1
                if value > arrCurrent.count || value == arrCurrent.count{
                    value -= 1
                 TimeInterval()

                }else{
                    var  dicLocal = [String : String]()

                    
                    
                    if strId == "1"{
                        let index = arrCurrent.index(where: {$0["queId"] == "2"})
                        nextIndexData(index, &dicLocal)
                       
                        
                    }else if  strId == "2"{
                        let index = arrCurrent.index(where: {$0["queId"]  == "3"})
                      nextIndexData(index, &dicLocal)
                        
                    }else if  strId == "3Y"{
                        let index = arrCurrent.index(where: {$0["queId"]  == "3"})
                       nextIndexData(index, &dicLocal)
                        
                    }else if  strId == "4Y"{
                        let index = arrCurrent.index(where: {$0["queId"]  == "3"})
                       nextIndexData(index, &dicLocal)
                        
                    }
                    


                    
                    
                    
                    
                    
                    
                    
                    
                    if  dicLocal["selected"] == "Yes"{
                        self.btnYes.setButtonImage("on.png")
                        self.btnNo.setButtonImage("off.png")
                    }else{
                        self.btnYes.setButtonImage("off.png")
                        self.btnNo.setButtonImage("on.png")
                        
                    }
                    
                    
                    self.lblYes.text = dicLocal["option1"]
                    self.lblNo.text = dicLocal["option2"]
                    let strID = dicLocal["queId"]
                    let quename = dicLocal["queText"]
                    strSelected = dicLocal["selected"]
                    self.lblQuestion.text  =   quename!
                 //   self.lblQuestionValueCount.text = strID! + " " + "of 19 Questions"
                    isYesbtnTap = true
                    self.btnprevious.isHidden = false
                    
                }
                
            }else{
                
                
               // TimeInterval()
                
            }
            

            
        }
    }
    
    // MARK:- Set Yes Button Data
    
    
    
    @IBAction func clickToBtnYes(_ sender: Any) {
        self.btnYes.setButtonImage("on.png")
        self.btnNo.setButtonImage("off.png")
        self.arrStartOrderData =  Array()
        self.isYesbtnTap = true
        strSelected = "Yes"
        let strId = arrQuestion?[value]["queId"] as? String
        
        self.isPreviousClick = false
        
    
       // dataForYes(strId!)
        
}
    
    
    
    fileprivate func dataForYes(_ strId: String) {
        if strId == "5Y"{
            serverSideData()
            
            
            
           // goToNext()
        }
            
        else if strId == "3"{
            serverSideData()
            
            
            //goToNext()
        }
        else{
            
            
            
            
            if strId == "2" {
                
                
                if let index = self.arrayPersnonID.index(of: "3Y") {
                    ////print(index)
                }
                else{
                    self.arrQuestion?.append(["queId": "3Y","queText": "Did you have corrective eye surgery?", "option1":"Yes","option2":"No"])
                    self.arrayPersnonID.append("3Y")
                }
                
                
            }
            if strId == "3Y"{
                
                if let index = self.arrayPersnonID.index(of: "4Y") {
                    ////print(index)
                }
                else{
                    self.arrQuestion?.append(["queId": "4Y","queText": "Was it monovision correction? (Was one eye corrected for reading and the other corrected for distance?", "option1":"Yes","option2":"No"])
                    self.arrayPersnonID.append("4Y")
                }
                
                
            }
            else if strId == "4Y"{
                
                if let index = self.arrayPersnonID.index(of: "5Y") {
                    ////print(index)
                    
                }
                else{
                    self.arrQuestion?.append(["queId": "5Y","queText": "Which eye was corrected for reading?", "option1":"Left","option2":"Right"])
                    
                    self.arrayPersnonID.append("5Y")
                    
                }
                
            }
            
            if isPreviousClick == true{
                
                value += 1
                if value > arrCurrent.count || value == arrCurrent.count{
                    value -= 1
                      TimeInterval()

                }else{
                    var  dicLocal = [String : String]()
                
                    _ = value-1
                  
                    
                    if strId == "1"{
                        let index = arrCurrent.index(where: {$0["queId"]  == "2"})
                        
                        nextIndexData(index, &dicLocal)
                        
                    }else if  strId == "2"{
                        let index = arrCurrent.index(where: {$0["queId"] == "3Y"})
                        nextIndexData(index, &dicLocal)
                        
                    }else if  strId == "3Y"{
                        let index = arrCurrent.index(where: {$0["queId"]  == "4Y"})
                       nextIndexData(index, &dicLocal)
                        
                    }else if  strId == "4Y"{
                        let index = arrCurrent.index(where: {$0["queId"]  == "5Y"})
                        nextIndexData(index, &dicLocal)
                        
                    }

                    
                    if  dicLocal["selected"] == "Yes"{
                        self.btnYes.setButtonImage("on.png")
                        self.btnNo.setButtonImage("off.png")
                    }else{
                        self.btnYes.setButtonImage("off.png")
                        self.btnNo.setButtonImage("on.png")
                        
                    }

                    self.lblYes.text = dicLocal["option1"]
                    self.lblNo.text = dicLocal["option2"]
                    let strID = dicLocal["queId"]
                    let quename = dicLocal["queText"]
                    strSelected = dicLocal["selected"]
                    self.lblQuestion.text  =   quename!
                //    self.lblQuestionValueCount.text = strID! + " " + "of 19 Questions"
                    isYesbtnTap = true
                    self.btnprevious.isHidden = false
                    
                }
                
            }else{
                
                
             // TimeInterval()
                
            }
            
         
        }
    }
    

    @objc func nextQues(){
        
        
        
        if isYesbtnTap == false{
            self.showToast(message: "Please select option")
            
        }else{
            nextDataSet()
            
        }
    }
    
    

    
    fileprivate func nextDataSet() {
        
        
        dicData["selected"] = strSelected
        dicData["option1"] = arrQuestion?[value]["option1"] as? String
        dicData["option2"] = arrQuestion?[value]["option2"] as? String
        dicData["queText"] = arrQuestion?[value]["queText"] as? String
        let strId = arrQuestion?[value]["queId"] as? String
        dicData["queId"] = strId
        self.arrAnswer = self.arrAnswer.filter { !$0.values.contains(strId!) }
        self.arrAnswer.append(dicData)
        self.btnprevious.isHidden = false

        self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(strId!)}
        self.arrCurrent.append(dicData)

       
        serverSideData()
        
        if (self.arrQuestion?.count == value){
            ECSAlert().showAlert(message: "Que overThanku", controller: self)
        }
        else{

            self.value += 1
            coreNextDataSet(self.value)
        }

        print("~~~~~~~~~~~~~~~~~arrAnswer~~~~~~~~~~~~~~~~~~~~~~~")
        print(self.arrAnswer)

        print("~~~~~~~~~~~~~~~~~arrCurrent~~~~~~~~~~~~~~~~~~~~~~~")
        print(self.arrCurrent)

    }
    


    
    
    fileprivate func coreNextDataSet(_ value: Int) {
        
        self.lblYes.text = arrQuestion?[value]["option1"] as? String
        self.lblNo.text = arrQuestion?[value]["option2"] as? String
        let strID = arrQuestion?[value]["queId"] as! String
        let quename = arrQuestion?[value]["queText"] as! String
        self.lblQuestion.text  =   quename
        //self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        self.isYesbtnTap = false
        self.view.isUserInteractionEnabled = true
        
    }
    
    
    
    
    fileprivate func serverSideData() {
        let  strId = arrQuestion?[value]["queId"] as! String
        
        dicAnsData["id"] = arrQuestion?[value]["queId"] as? String
        dicAnsData["ans"] = strSelected
        self.serverArray = self.serverArray.filter { !$0.values.contains(strId) }
        self.serverArray.append(dicAnsData)
        dicData["selected"] = strSelected
        dicData["option1"] = arrQuestion?[value]["option1"] as? String
        dicData["option2"] = arrQuestion?[value]["option2"] as? String
        dicData["queText"] = arrQuestion?[value]["queText"] as? String
        dicData["queId"] = strId
        self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(strId)}
        self.arrCurrent.append(dicData)
    }
    

    
    
    func goToNext() {
        var strCheckValue = ""
        self.serverArray = serverArray.compactMap { $0 }
       
         print("~~~~~~~~~~~~~~~~~ServerArray~~~~~~~~~~~~~~~~~~~~~~~")
        print(self.serverArray)

        for dic in self.serverArray{
            if "1" == dic["id"]{
                strCheckValue = dic["ans"] ?? ""
            }
        }
        
        
        let vc = StartOrderd(nibName: "StartOrderd", bundle: nil)

        vc.serverArraySecond = serverArray
        vc.delegate = self
        vc.arrCurrent = arrStartOrderData
        
        if strCheckValue == "No"{
           vc.isMale = false
        }else{
            vc.isMale = true
        }
        
        if isImageDataEmpty == true{
            vc.isImageDataEmpty = true
            vc.strError = self.strError
        }else{
             vc.arrImage = arrImage
        }
       
        self.navigationController?.pushViewController(vc, animated: true)

    }
    


    

    
    
    
    //MARK:- Previous Set Data
    
    
    @IBAction func clickToPrivious(_ sender: Any) {
        //print("main value is\(value) ")
        
        self.btnNo.isEnabled = true
        self.btnYes.isEnabled = true
        
        if (value == 0){
         
                _ = SweetAlert().showAlert("Alert", subTitle: "Are you sure you want to restart the               evaluation?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        
                        
                    }
                    else {
                        
                        let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            
            
            
           
            
            
          
           
        }
        else{
            

            
            self.setPriviousSubData()
            
            
            
            
        }
        
    }
    
    
    fileprivate func setPriviousSubData(){
      
        
       
  
        
        let localIdForserverArray = arrQuestion?[value]["queId"] as! String
        let indexServer = serverArray.index(where: {$0["id"]  == localIdForserverArray})
        if indexServer != nil {
            serverArray.remove(at: indexServer!)

        }
        //print(serverArray)
        self.arrQuestion?.remove(at: value)
        self.arrayPersnonID.remove(at: value)
        value -= 1
        let localId = arrQuestion?[value]["queId"] as! String
        

        let index = arrAnswer.index(where: {$0["queId"] == localId})
        

        if index != nil {
            setPreviousData(valueindex: index!)
        }
        
        self.isPreviousClick = true
    }
    
    
    func setImageUrl(str:String){
        let Array = arrImage[0] as! [HomeData]
        let objeDeram = Array[16]
        UserDefaults.standard.setValue(objeDeram.banner, forKey: "dreamweave")
         let objeFlex = Array[17]
         UserDefaults.standard.setValue(objeFlex.banner, forKey: "flex")
            UserDefaults.standard.synchronize()
        if str == "1"{
            let obje = Array[0]
            
            imgBanner.kf.indicatorType = .activity
            let urlbaner = URL(string: obje.banner)
            imgBanner.kf.setImage(with: urlbaner)
        }else if str == "2"{
            let obje = Array[1]
      
            imgBanner.kf.indicatorType = .activity
            let urlbaner = URL(string: obje.banner)
            imgBanner.kf.setImage(with: urlbaner)
        }else if str == "3"  {
            let obje = Array[3]
          
            imgBanner.kf.indicatorType = .activity
            let urlbaner = URL(string: obje.banner)
            imgBanner.kf.setImage(with: urlbaner)
        }else if str == "3Y" || str == "4Y" || str == "5Y"{
            let obje = Array[2]
            
            imgBanner.kf.indicatorType = .activity
            let urlbaner = URL(string: obje.banner)
            imgBanner.kf.setImage(with: urlbaner)
        }
        
       
    }
    
 
    
    
    
    
    
    func setPreviousData(valueindex : Int){
        

        //print(valueindex)
    
        isback = false
        var dicdata  = arrAnswer[valueindex] 
        
        self.lblYes.text = dicdata["option1"]
        self.lblNo.text = dicdata["option2"]
        let strID = dicdata["queId"]
        let quename = dicdata["queText"]
     
        self.lblQuestion.text  =   quename!

       let   strSelectedValue = dicdata["selected"]
        
        self.btnYes.setButtonImage("off.png")
        self.btnNo.setButtonImage("off.png")
        
        
        if strSelectedValue == "Yes"{
            if strID == "4Y" || strID == "3Y" || strID == "5Y"{
               
                self.btnVideo.isHidden = true
            }else{
               
                self.btnVideo.isHidden = false
                
            }
            self.btnYes.setButtonImage("on.png")
            self.btnNo.setButtonImage("off.png")
            strSelected = "Yes"
        }
        else if strSelectedValue == "No"{
            self.btnYes.setButtonImage("off.png")
            self.btnNo.setButtonImage("on.png")
            strSelected = "No"
        }
         self.setImageUrl(str:(arrQuestion?[value]["queId"] as? String)! )
        
        if strID == "1"{
            self.btnprevious.isHidden = false
            
            self.btnNext.isEnabled = true
         //   self.serverArray.removeAll()
            self.arrayPersnonID.removeAll()
            value = 0
            self.arrayPersnonID.append("1")
            self.arrayPersnonID.append("2")
            
            arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
            
            
            
        }
        
        
        
        self.isPreviousClick = true
        
        self.isYesbtnTap = true

        print("~~~~~~~~~~~~~~~~~arrAnswerPrevious~~~~~~~~~~~~~~~~~~~~~~~")
        print(self.arrAnswer)

        print("~~~~~~~~~~~~~~~~~arrCurrentPrevious~~~~~~~~~~~~~~~~~~~~~~~")
        print(self.arrCurrent)
    }
    
    
}

