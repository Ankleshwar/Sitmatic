//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

protocol  StartOrderdDelegate {
    func setDataOnBack(isBack:Bool,arrSaveValue:[[String: String]])
}

let arrMale = [ "8.00", "19.50", "18.50", "32.00", "9.50", "16.50", "14.00"]
let arrFemale = [ "8.00", "19.00", "17.00", "30.00", "9.00", "15.00", "17.00"]

    class StartOrderd: BaseViewController , OrderProccessingSecondDelegate{

        var strError = String()
        @IBOutlet weak var imgBanner: UIImageView!
        @IBOutlet weak var topView: UIView!
        var isMale = false
        var isImageDataEmpty = false
        var strIndex = ""
         var arrImage = NSMutableArray()
        var arrCurrent: [[String: String]]  = Array()
        var isBack = false
        var isButtonCheck = false
        var isPriviousClick = false
         @IBOutlet weak var viewContainer: UIView!
        @IBOutlet weak var imgConstraintTopHeight: NSLayoutConstraint!
        @IBOutlet weak var btnVideoConstraintTopHeight: NSLayoutConstraint!
        var dicAnsData = Dictionary<String, String>()
        var strInce: String!
        var delegate: StartOrderdDelegate?
        @IBOutlet var pickerView: UIPickerView!
        @IBOutlet weak var btnNext: UIButton!
        var count = 0
        @IBOutlet weak var btnCancle: UIButton!
        @IBOutlet weak var btnPrevious: UIButton!

        @IBOutlet weak var txtField: UITextField!

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


        fileprivate func setPickerOrder() {
            let countSize = (self.arrIteam?.count)!/2
            self.pickerView.selectRow(countSize, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: countSize, inComponent: 0)


        }

        override func viewDidLoad() {
            super.viewDidLoad()

            self.setTopView(self.topView, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
            textField(color:UIColor.black)
            if isMale{
                 arrQuestion = (setDataWithLocalJson("NextVersionMale") as NSArray as? Array<Dictionary<String, Any>>)!
            }else
            {
                 arrQuestion = (setDataWithLocalJson("NextVersionFemale") as NSArray as? Array<Dictionary<String, Any>>)!
            }

            self.isFirstQuestion = true
            self.strInce = "8"
            self.strValue = "5"
            self.ansStrIn = "68"
            print("viewDidLoadCall")

            self.setImageUrl(str:(arrQuestion[count]["questionId"] as? Int)!)

            if isImageDataEmpty == true{
                imgBanner.image = UIImage(named: "banner")
            }


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

                     //   self.lblQuestionValueCount.text = dicLocal["questionId"]! + " " + "of 19 Questions"
                        self.arrIteam?.removeAll()
                        self.arrIteam = arrQuestion[count]["value"] as? Array
                        self.arrInch = arrQuestion[0]["inch"] as? Array
                        self.arrIteam = arrQuestion[0]["value"] as? Array
                     //   setPickerOrder()

                        self.arrAnswer.append(dicLocal)
                        self.isPriviousClick = true

                    }else{

                        lblQuestion.text = arrQuestion[0]["questionText"] as? String
                        self.arrIteam = arrQuestion[0]["value"] as? Array
                        let id : Int = (arrQuestion[count]["questionId"] as? Int)!
                        self.arrInch = arrQuestion[0]["inch"] as? Array
                        self.arrIteam = arrQuestion[0]["value"] as? Array
                      //  self.lblQuestionValueCount.text = String(id) + " " + "of 19 Questions"
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

        @objc func rightButtonClicked(_ sender: Any) {
            let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)

            self.navigationController?.pushViewController(vc, animated: true)
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

        @IBAction func clickToSuggest(_ sender: Any) {
            if isImageDataEmpty == true {
                self.showToast(message: strError)


            }else{



            if (sender as AnyObject).tag == 1 {

                self.setImageUrl(str:(arrQuestion[count]["questionId"] as? Int)!)
    //            let viewSubData = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(200), width: CGFloat(self.screenWidth), height: CGFloat(400)))
    //            viewSubData.addSubview(self.viewSub)
    //            viewSubData.backgroundColor = UIColor.clear
    //            viewSubData.tag = 500
    //            self.view.addSubview(viewSubData)


            }else if (sender as AnyObject).tag == 3 {
                let Array = arrImage[0] as! [HomeData]
                let idIndex = (arrQuestion[count]["questionId"] as? Int)! - 1
                let objeHome = Array[idIndex]


                let videoURL = URL(string: objeHome.video)
                let playerItem = CachingPlayerItem(url: videoURL!)
                let player = AVPlayer(playerItem: playerItem)
                player.automaticallyWaitsToMinimizeStalling = true
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player



                self.present(playerViewController, animated: true) {

                    playerViewController.player!.play()

                }
            }

            else{

    //            viewSub.removeFromSuperview()
    //
    //            if let viewWithTag = self.view.viewWithTag(500) {
    //
    //                viewWithTag.removeFromSuperview()
    //            }
    //
            }
                 }
        }

        func setImageUrl(str:Int){


            let Array = arrImage[0] as! [HomeData]
             let idIndex = str - 1
            let obje = Array[idIndex]
            imgBanner.kf.indicatorType = .activity
            let urlbaner = URL(string: obje.banner)
            imgBanner.kf.setImage(with: urlbaner)

            if str == 5{

            }else{
                setPickerIndex(id: str)
            }
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
            var hieght = Int()
            if(self.isFirstQuestion == true){
                if strValue == "ft"{
                    //self.showToast(message: "Please select a valid value")
                    strValue = "5"


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
                    textField(color:UIColor.black)
                    hieght = Int(strValue)!*12 + Int(strInce)!
                    UserDefaults.standard.set(hieght, forKey: "userHieght")
                     UserDefaults.standard.synchronize()
                }

                self.txtField.text = strValue + "ft" + " "  + strInce + "in"
                hieght = Int(strValue)!*12 + Int(strInce)!
                UserDefaults.standard.set(hieght, forKey: "userHieght")
                UserDefaults.standard.synchronize()
            }
            else{
                self.txtField.text = strValue
                textField(color:UIColor.black)
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
            self.txtField.layer.borderWidth = 0.7
            self.txtField.layer.borderColor = color.cgColor
           // self.txtField.layer.cornerRadius = 5.0
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
                        vc.isImageDataEmpty = isImageDataEmpty
                        vc.arrImage = arrImage
                        vc.strError = strError
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

                           //     self.lblQuestionValueCount.text = dicLocal["questionId"]! + " " + "of 19 Questions"
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
                               // self.lblQuestionValueCount.text = String(id) + " " + "of 19 Questions"
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
                         //   self.lblQuestionValueCount.text = String(id) + " " + "of 19 Questions"
                            self.arrIteam?.removeAll()
                            self.arrIteam = arrQuestion[count]["value"] as? Array
                            self.strValue = ""

                        }






                    }


                }


            }
            self.view.isUserInteractionEnabled = true
        }

        func setPickerIndex(id:Int){

            if isMale {
                switch(id){
                case (6):
                    strIndex = arrMale[0]
                    break
                case (7):
                    strIndex = arrMale[1]
                    break
                case (8):
                    strIndex = arrMale[2]
                    break
                case (9):
                    strIndex = arrMale[3]
                    break
                case (10):
                    strIndex = arrMale[4]
                    break
                case (11):
                    strIndex = arrMale[5]
                    break
                case (12):
                    strIndex = arrMale[6]
                    break
                default: break

                }
            }else{
                switch(id){
                case (6):
                    strIndex = arrFemale[0]
                    break
                case (7):
                    strIndex = arrFemale[1]
                    break
                case (8):
                    strIndex = arrFemale[2]
                    break
                case (9):
                    strIndex = arrFemale[3]
                    break
                case (10):
                    strIndex = arrFemale[4]
                    break
                case (11):
                    strIndex = arrFemale[5]
                    break
                case (12):
                    strIndex = arrFemale[6]
                    break
                default: break

                }
            }
        }





        @IBAction func clickToNext(_ sender: Any) {


             let controllerVelue = UserDefaults.standard.integer(forKey: "userHieght")
            let  queId  = (arrQuestion[count]["questionId"] as? Int)!
            if queId == 5{
                if isMale{

                    if controllerVelue > 86 {

                        self.showToast(message: "Maximum Male Height Limt is 7ft 2in")

                    }else{
                        setDataOnNext()
                        self.setImageUrl(str:(arrQuestion[count]["questionId"] as? Int)!)
                    }
                }else{

                    if controllerVelue > 82 {

                        self.showToast(message: "Maximum Female Height Limt is 6ft 10in")
                    }else{
                        setDataOnNext()
                        self.setImageUrl(str:(arrQuestion[count]["questionId"] as? Int)!)
                    }

                }
            }else{
                setDataOnNext()
                self.setImageUrl(str:(arrQuestion[count]["questionId"] as? Int)!)
            }







        }

        @IBAction func clickToPrevious(_ sender: Any) {
            self.isButtonCheck = false

    //textField(color:UIColor.white)
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
                   // self.lblQuestionValueCount.text = id + " " + "of 19 Questions"
                    if id == "5"{
                        self.btnPrevious.isHidden =  false
                        self.isFirstQuestion = true


                    }
                    lblQuestion.text = dicdata["questionText"]
                    self.txtField.text = dicdata["selected"]
                    self.arrIteam = arrQuestion[count]["value"] as? Array
                     self.setImageUrl(str:(arrQuestion[count]["questionId"] as? Int)!)

                    if self.isFirstQuestion == true{

                        let strMain = dicdata["selected"]
                        let fullNameArr = strMain?.components(separatedBy: " ")
                        self.strValue =  fullNameArr![0]
                        self.strInce = fullNameArr![1]
                        if isMale{
                            arrQuestion = (setDataWithLocalJson("NextVersionMale") as NSArray as? Array<Dictionary<String, Any>>)!
                        }else
                        {
                            arrQuestion = (setDataWithLocalJson("NextVersionFemale") as NSArray as? Array<Dictionary<String, Any>>)!
                        }
                       //  self.setImageUrl(str: 0)
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



        fileprivate func setPicker(){
               var indexArray = Int()
             self.pickerView.reloadAllComponents()
            if isMale{
                if isFirstQuestion == true{
                    self.pickerView.selectRow(3, inComponent: 0, animated: true)
                    self.pickerView(pickerView, didSelectRow: 3, inComponent: 0)
                    self.pickerView.selectRow(9, inComponent: 1, animated: true)
                    self.pickerView(pickerView, didSelectRow: 9, inComponent: 1)
                }else{
                    for i in 0..<arrIteam!.count {
                        let str = arrIteam?[i] as! String
                        if str == self.strIndex{
                            indexArray = i
                        }

                    }
                    print(indexArray)
                    self.pickerView.reloadAllComponents()
                    self.pickerView.selectRow(indexArray, inComponent: 0, animated: true)
                    self.pickerView(pickerView, didSelectRow: indexArray, inComponent: 0)
                }

            }else{


                if isFirstQuestion == true{
                    self.pickerView.selectRow(3, inComponent: 0, animated: true)
                    self.pickerView(pickerView, didSelectRow: 3, inComponent: 0)
                    self.pickerView.selectRow(4, inComponent: 1, animated: true)
                    self.pickerView(pickerView, didSelectRow: 4, inComponent: 1)
                }else{
                    for i in 0..<arrIteam!.count {
                        let str = arrIteam?[i] as! String
                        if str == self.strIndex{
                            indexArray = i
                        }

                    }
                    print(indexArray)
                    self.pickerView.reloadAllComponents()
                    self.pickerView.selectRow(indexArray, inComponent: 0, animated: true)
                    self.pickerView(pickerView, didSelectRow: indexArray, inComponent: 0)
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
        print(self.strIndex)

   let strId =  (arrQuestion[count]["questionId"] as? Int)!
        
        if isPriviousClick == true {
            let index = serverArraySecond.index(where: {$0["id"]  == String(strId)})
            
            if index == nil{

                        setPicker()

            }else{
                if NSString(string: strValue).contains("ft") {
                    
                    strValue = String(strValue.dropLast(2))
                    print(strValue)
                }
                if NSString(string: strInce).contains("in") {
                    
                    strInce = String(strInce.dropLast(2))
                    print(strInce)
                }
                
                for i in 0..<arrIteam!.count {
                    let str = arrIteam?[i] as! String
                    if str == self.strValue{
                        indexArray = i
                    }
                    
                }
                if isFirstQuestion{
                      var indexArrayInch = Int()
                    for i in 0..<arrInch!.count {
                        let str = arrInch?[i] as! String
                        if str == self.strInce{
                            indexArrayInch = i
                        }
                        
                    }
                    self.pickerView.reloadAllComponents()
                    self.pickerView.selectRow(indexArrayInch, inComponent: 1, animated: true)
                    self.pickerView(pickerView, didSelectRow: indexArrayInch, inComponent: 1)
                }
                
        
                    self.pickerView.reloadAllComponents()
                    self.pickerView.selectRow(indexArray, inComponent: 0, animated: true)
                    self.pickerView(pickerView, didSelectRow: indexArray, inComponent: 0)
                
                
                
                
               
            }
            
          
          

            
            print(indexArray)
            
            
        }else{
                setPicker()
            }
        
        
        

    

        
        
        
        
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









extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

