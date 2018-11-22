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

protocol OrderProccessingSecondDelegate  {
    func setData(arrData:[[String: String]],isbackValue:Bool)
}



    class OrderProccessingSecond: BaseViewController , ModifyModelDelegate,OrderProccessingNewDelegate{

        @IBOutlet weak var btnTryAgain: UIButton!
        @IBOutlet weak var viewCallHeight: NSLayoutConstraint!

        @IBOutlet weak var imgBanner: UIImageView!
        @IBOutlet weak var viewCallTop: UIView!

        @IBOutlet weak var viewTop: UIView!

        @IBOutlet weak var btnVideo: UIButton!

        var strError = String()
        var isImageDataEmpty = false
        var arrImage = NSMutableArray()



        var sucessObj : SuccessData!
        var strValueID = ""
        var strprice = ""
        @IBOutlet weak var lblModelCode: UILabel!
        @IBOutlet var viewCall: UIView!
       var questionsArray : [Question]!
        @IBOutlet weak var viewDetails: UIView!
        @IBOutlet weak var lblModel: UILabel!
        @IBOutlet weak var lblprice: UILabel!
        @IBOutlet var viewSubView: UIView!

        @IBOutlet weak var viewQuestion: UIView!

        @IBOutlet weak var viewContainer: UIView!
        @IBOutlet weak var imgConstraintTopHeight: NSLayoutConstraint!
        @IBOutlet weak var btnVideoConstraintTopHeight: NSLayoutConstraint!
        @IBOutlet weak var imgCallHeight: NSLayoutConstraint!

        @IBOutlet weak var imgCallWidth: NSLayoutConstraint!
        @IBOutlet weak var viewContainerCall: UIView!


        @IBOutlet weak var btnCancle: UIButton!

        @IBOutlet weak var tableViewieght: NSLayoutConstraint!
        @IBOutlet weak var viewScrollHeight: NSLayoutConstraint!
        var dicPreviousData = Dictionary<String, Any>()
        @IBOutlet weak var txtModelNumber: UITextField!

        var delegate : OrderProccessingSecondDelegate?
        var dicAnsData = Dictionary<String, String>()
        var isFirstQue: Bool!
        var strArme = String()
        @IBOutlet weak var tableView: UITableView!
        var arrQuestion: Array<Dictionary<String,Any>>?
         var arrAnswer: [[String: String]]  = Array()

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

        @IBOutlet weak var viewSubTop: UIView!





        @IBOutlet weak var lblQuestion: UILabel!

        override func viewDidLoad() {
            super.viewDidLoad()
            self.btnTryAgain.layer.cornerRadius = 20.0
            self.btnTryAgain.clipsToBounds = true
            self.setTopView(self.viewTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
            self.setTopView(self.viewSubTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
                  self.setTopView(self.viewCallTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
            print(arrImage)
           //  self.viewSub.isHidden = true
            arrQuestion = setDataWithLocalJson("OrderProccessingSecond") as NSArray as? Array<Dictionary<String, Any>>
            setInitial()
            self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
            self.tableView.separatorStyle = .none
            self.tableView.backgroundColor = UIColor.clear
            self.tableView.backgroundColor = UIColor.clear
            self.tableView.layer.borderWidth = 0.5
            self.tableView.layer.borderColor = UIColor.lightGray.cgColor


    //        self.setShadow(self.viewDetails)
//            self.setShadow(self.viewModel)

              self.setImageUrl(str:(arrQuestion?[value]["queId"] as! String) )
        }

        func setShadow(_ view: UIView){

            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize.zero
            view.layer.shadowRadius = 2

        }

        func setData(arrData: [[String : String]], isbackValue: Bool) {
    //        arrQuestion = setDataWithLocalJson("OrderProccessingSecond") as NSArray as? Array<Dictionary<String, Any>>
      //      strValueID = "13"
    //        value = 0
    //        self.setInitial()
        }


        func setInitial(){
            self.lblYes.text = arrQuestion?[0]["option1"] as? String
            self.lblNo.text = arrQuestion?[0]["option2"] as? String
            //self.lblQuestion.text  = arrQuestion?[0]["queText"] as? String

            let strID = arrQuestion?[value]["queId"] as! String
            let quename = arrQuestion?[value]["queText"] as! String
            //self.lblQuestion.text  = strID + " " + quename
            self.lblQuestion.text  =   quename
           //  self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"

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


    //                dicNext["selected"] = strSelected
    //                dicNext["option1"] = arrQuestion?[value]["option1"] as? String
    //                dicNext["option2"] = arrQuestion?[value]["option2"] as? String
    //                dicNext["queText"] = arrQuestion?[value]["queText"] as? String
    //                dicNext["queId"] = arrQuestion?[value]["queId"] as? String
                    strValueID = arrQuestion?[value]["queId"] as? String ?? ""


                    self.btnVideo.isHidden = false

                   // self.arrQuestion?.remove(at: value)

                    value -= 1


                    let localId = arrQuestion?[value]["queId"] as! String


                    let index = arrAnswer.index(where: {$0["queId"] as! String == localId})

                    print(index)
                    if index != nil {
                        setPreviousData(valueindex: index!)
                    }

                    self.isPreviousClick = true

                     self.setImageUrl(str:(arrQuestion?[value]["queId"] as! String) )

                     serverArrayThid.remove(at: value)



                }

            }


        }


        func setValuenext(){


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


        @IBAction func clickToNext(_ sender: Any) {
            print(value)

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
               // self.btnGallery.isHidden = true
                 self.btnVideo.isHidden = true


                if strValueID == "17" {
                    if strSelected == "No"{
                        self.setNoNextScreen()
                    }else{
                        self.setNextData()
                    }

                }else{
                    if arrQuestion?[value]["queId"] as? String == "15"{
                        if strSelected == "No"{
                            let Array = arrImage[0] as! [HomeData]
                             let obje = Array[15]
                                    let vc = OrderProccessingNew(nibName: "OrderProccessingNew", bundle: nil)
                                    vc.delegateNew = self
                                    vc.serverArrayThid = serverArrayThid
                                    vc.strImgeUrl = obje.image
                                    vc.strVideoUrl = obje.video
                                    vc.strImgeUrlbanner = obje.banner
                                    self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                           callApi()
                        }

                    }else{
                         imgBanner.image = UIImage(named: "banner.png")
                        nextQues()
                        self.setImageUrl(str:(arrQuestion?[value]["queId"] as! String) )
                    }


                }



            }

        }



        override func viewDidLayoutSubviews() {

            UIView().setShadowImg(self.imgBanner)
            UIView().setShadow(self.viewContainerCall)
            UIView().setShadow(self.viewContainer)
             UIView().setShadow(self.viewModel)
    //        self.viewContainerCall.layer.cornerRadius = 5.0
    //        self.viewContainerCall.clipsToBounds = true

            if device.diagonal == 4{
                self.btnVideoConstraintTopHeight.constant = 35.0
                self.imgConstraintTopHeight.constant = 25.0
            }else   if device.diagonal == 4.7{

                self.imgConstraintTopHeight.constant = 30.0
                self.btnVideoConstraintTopHeight.constant = 40.0
                self.imgCallWidth.constant = 80.0
                self.imgCallHeight.constant = 80.0

            }else   if device.diagonal == 5.5{
                self.imgConstraintTopHeight.constant = 35.0
                self.btnVideoConstraintTopHeight.constant = 45.0
                self.imgCallWidth.constant = 100.0
                self.imgCallHeight.constant = 100.0
                 self.viewCallHeight.constant =  220.0
            }
            else {

                self.imgConstraintTopHeight.constant = 40.0
                self.btnVideoConstraintTopHeight.constant = 50.0
                self.imgCallWidth.constant = 80.0
                self.imgCallHeight.constant = 80.0
                self.viewCallHeight.constant =  250.0

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
                self.arrAnswer = self.arrAnswer.filter { !$0.values.contains(dicData["queId"]!) }
                self.arrAnswer.append(dicData)
                print("at add time\(dicData)")

                if arrQuestion?[value]["queId"] as? String == "15" {
                      self.btnprevious.isHidden = true

                }else{
                      self.btnprevious.isHidden = false
                }



                serverSideData()


                if (self.arrQuestion?.count == value){
                    ECSAlert().showAlert(message: "Que overThanku", controller: self)
                }
                else{

    //                if self.isPreviousClick == true{
    //                    value += 1
    //                    setData(value: value)
    //                }else{
    //                    value += 1
    //                    setData(value: value)
    //                }
    //
                        value += 1
                     setData(value: value)





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

            if strId == "15"{
                serverSideData()
                 strValueID = "15"
               // callApi()
            }else{


    //            self.view.isUserInteractionEnabled = false
    //            Timer.scheduledTimer(timeInterval: 0.5,
    //                                 target: self,
    //                                 selector: #selector(self.nextQues),
    //                                 userInfo: nil,
    //                                 repeats: false)

            }






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
    //        let vc = OrderProccessingNew(nibName: "OrderProccessingNew", bundle: nil)
    //        vc.serverArrayThid = serverArrayThid
    //        self.navigationController?.pushViewController(vc, animated: true)
                callGenrateModelApi(strData: strJson!)
        }
        func setImageUrl(str:String){
            let Array = arrImage[0] as! [HomeData]
            if str == "13"{
                let obje = Array[12]

                imgBanner.kf.indicatorType = .activity
                let urlbaner = URL(string: obje.banner)
                imgBanner.kf.setImage(with: urlbaner)
            } else if str == "14"{
                let obje = Array[13]

                imgBanner.kf.indicatorType = .activity
                let urlbaner = URL(string: obje.banner)
                imgBanner.kf.setImage(with: urlbaner)
            } else if str == "15"{
                let obje = Array[14]

                imgBanner.kf.indicatorType = .activity
                let urlbaner = URL(string: obje.banner)
                imgBanner.kf.setImage(with: urlbaner)
            }
            else{
                imgBanner.image = UIImage(named: "banner.png")
            }

        }



        @IBAction func clickToSuggest(_ sender: Any) {
            if isImageDataEmpty == true{
                self.showToast(message: strError)
            }else{




                if (sender as AnyObject).tag == 1 {

                    self.setImageUrl(str:(arrQuestion?[value]["queId"] as! String) )

                   // self.viewSub.isHidden = false
                }
                else if (sender as AnyObject).tag == 3 {
                    let Array = arrImage[0] as! [HomeData]
                    var strUrl = String()
                    if (arrQuestion?[value]["queId"] as? String)! == "13"{
                        strUrl = Array[12].video

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

                  //  self.viewSub.isHidden = true
                }
            }
        }








        fileprivate func addSubView(_ obj: SuccessData) {
            self.viewSubView.frame = self.view.bounds
            self.view.addSubview(self.viewSubView)


             self.tableViewieght.constant = CGFloat((self.arrModelDescription?.count)! * 60 + 10 + 60)
            let modelName = UIDevice.modelName
               let frame = self.viewQuestion.frame.origin.y+self.viewQuestion.frame.height+20
            if modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone 5" || modelName == "iPhone SE" {
               self.viewScrollHeight.constant =   CGFloat((self.arrModelDescription?.count)! * 60 + 10 + 60) + CGFloat(frame) + CGFloat(20)
            }
            else{
                self.viewScrollHeight.constant =   CGFloat((self.arrModelDescription?.count)! * 60 + 10 + 60) + CGFloat(frame)
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
            self.lblModel.text = "We're almost done! So far," +  " "  + "your ideal chair model is:"
            self.lblModelCode.text = obj.proposedModel
            //self.lblprice.text = obj.proposedPrice
            self.lblprice.text = "List Price:" + " " + "$" + String(obj.proposedPrice)
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            self.btnNext.isHidden = true
            self.btnCancle.isEnabled = true
            let sendData = obj


        }

        func callGenrateModelApi(strData : String){

            let dic = ["data": strData,
                       "user_id":(self.appUserObject?.userId)!,
                       "name": (self.appUserObject?.lastName)!,
                       "organization_name": self.appUserObject?.countryCode ?? "",
            ]

            print(dic)

            SVProgressHUD.show()
            var  strName = (self.appUserObject?.access_token)!
            strName = "savebasicquestions?token=\(strName)"


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
                        self.strValueID = "17"

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
            let strId = arrQuestion?[value]["queId"] as? String


            if strId == "15"{
                serverSideData()
                 strValueID = "15"

            }
            else{
    //            Timer.scheduledTimer(timeInterval: 0.3,
    //                                 target: self,
    //                                 selector: #selector(nextQues),
    //                                 userInfo: nil,
    //                                 repeats: false)
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

          //  self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"

            self.btnYes.setButtonImage("off.png")
            self.btnNo.setButtonImage("off.png")
            self.isYesbtnTap = false
            self.view.isUserInteractionEnabled = true
        }

        func setPreviousData(valueindex : Int){

            print(arrAnswer)


            var dicdata  = arrAnswer[valueindex]


            print("at remove time\(dicdata)")


            self.lblYes.text = dicdata["option1"]
            self.lblNo.text = dicdata["option2"]
            let strID = dicdata["queId"]
            let quename = dicdata["queText"]
            //self.lblQuestion.text  = strID! + " " + quename!
            self.lblQuestion.text  =   quename!
          //  self.lblQuestionValueCount.text = strID! + " " + "of 19 Questions"
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

            if strID == "13"{


                self.btnNext.isEnabled = true
                self.isFirstQue = true

                value = 0


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
            return 120.0
        }else{
            return 60.0
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
