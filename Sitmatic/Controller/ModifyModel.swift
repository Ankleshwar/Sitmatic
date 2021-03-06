//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit


protocol ModifyModelDelegate {
    func setDataOnPrevious(dicValue:[String:Any])
}



class ModifyModel: BaseViewController {

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblErrorSub: UILabel!
    
    @IBOutlet weak var imageBanner: UIImageView!
    
    @IBOutlet weak var imgBannerSecond: UIImageView!

    @IBOutlet weak var viewControl: UIView!
     @IBOutlet weak var imgConstraintTopHeight: NSLayoutConstraint!
    @IBOutlet weak var imgSecondConstHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewBacrestSize: UIView!
    @IBOutlet weak var viewBackrestSizeHeight: NSLayoutConstraint!
    var delegate: ModifyModelDelegate?
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    var arrQuesOfModifiy:[Question]?
    var isBackRestFour = false
    @IBOutlet weak var lblSeatAngle: UILabel!
    @IBOutlet weak var lblSeatAngleQue: UILabel!
    @IBOutlet weak var lblSeatDepthQue: UILabel!
    @IBOutlet weak var lblSeatDepth: UILabel!
    @IBOutlet weak var viewBackrestHeight: NSLayoutConstraint!
    @IBOutlet weak var btnArmrestHeight: NSLayoutConstraint!
    @IBOutlet weak var btnArmrestCap: NSLayoutConstraint!
    @IBOutlet weak var btnArmrestSpecialHeight: NSLayoutConstraint!
    @IBOutlet weak var viewArmrestSpecialHeight: NSLayoutConstraint!
    @IBOutlet weak var viewArmrestCap: NSLayoutConstraint!
    @IBOutlet weak var viewArmrestHeight: NSLayoutConstraint!
    @IBOutlet weak var lblArmrestOption: UILabel!
    @IBOutlet weak var btnBackrestSizeHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSeatSize: UILabel!
    @IBOutlet weak var lblBackrestPosition: UILabel!
    @IBOutlet weak var lblArmrests: UILabel!
    @IBOutlet weak var lblArmcap: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblCasters: UILabel!
    @IBOutlet weak var lblFootrest: UILabel!
    @IBOutlet weak var lblMesh: UILabel!
    var selectedOptions = [String]()
    @IBOutlet weak var lblSeatHieght: UILabel!
    @IBOutlet weak var lblSeatOption: UILabel!
    @IBOutlet weak var lblCantrol: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblMeshQue: UILabel!
    
    @IBOutlet weak var lblControllQue: UILabel!
    @IBOutlet weak var lblBackrestOption: UILabel!
    @IBOutlet weak var lblSeatsizeQue: UILabel!
    @IBOutlet weak var lblSeatsizeOptionsQue: UILabel!
    @IBOutlet weak var lblSeatheightQue: UILabel!
    
    @IBOutlet weak var lblbackrestsizeQue: UILabel!
    
    @IBOutlet weak var lblArmrestQue: UILabel!
    
    @IBOutlet weak var lblArmrestCapQue: UILabel!
    
    @IBOutlet weak var lblArrestHeightQue: UILabel!
    
    @IBOutlet weak var lblBaseQue: UILabel!
    
    @IBOutlet weak var lblFootrestQue: UILabel!
    
    @IBOutlet weak var lblCastersQue: UILabel!
    
    @IBOutlet weak var viewTopSecond: UIView!
    
    
    @IBOutlet weak var viewSecondContainer: UIView!
    
    
    @IBOutlet weak var viewSeatDepth: UIView!
    
    
    
    
    
    var dicSelected = Dictionary<String, Any>()
    var textField : UITextField!
    var imagViewForPicker = UIImageView()
    @IBOutlet var viewSub: UIView!

    var dicAnsData = Dictionary<String, String>()
    var strInce: String!
    @IBOutlet var pickerView: UIPickerView!
    var isMesh = false
    @IBOutlet weak var lblbackRestSize: UILabel!
    var count = 0
   var successDataObject : SuccessData!

    
   
    
    
    var arrIteam :Array<String>?
   
    var strValue: String = ""
    var strArmrest: String = "No"
 
    var arrAnswer = NSMutableArray()
    var serverArraySecond: [[String: String]]  = Array()
    var dicData = Dictionary<String, Any>()
    
    @IBOutlet weak var viewFirstCantainer: UIView!
    var ansStrIn: String!
    var isFirstQuestion: Bool!
    
     var arrSections = [Section]()
    var index = 100
    var arrQuestion: Array<Dictionary<String,Any>>?
    
    @IBOutlet weak var viewTopFirst: UIView!
    
    
    @IBAction func clickToDone(_ sender: Any) {
        print(dicSelected)
        let vc = OrderProccessingThird(nibName: "OrderProccessingThird", bundle: nil)
        vc.Modifie = "1"
        vc.dicServerSide = dicSelected
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.lblError.isHidden = true
        self.lblErrorSub.isHidden = true
        arrQuestion = (setDataWithLocalJson("ModifiModel") as NSArray as? Array<Dictionary<String, Any>>)!
        self.setTopView(self.viewTopFirst, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
        self.setTopView(self.viewTopSecond, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user.png", withoutBackButton: true)
        
        self.arrIteam = self.arrQuesOfModifiy![0].options
      
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8117647059, blue: 0.8392156863, alpha: 1)
        self.tableView.isHidden = true
        
        
        setSlectedValue()


        if self.strArmrest == "No"{
            self.viewArmrestCap.constant = 0
            self.btnArmrestCap.constant = 0
            self.viewArmrestHeight.constant = 0
            self.btnArmrestHeight.constant = 0
            self.viewArmrestSpecialHeight.constant = 0
            self.btnArmrestSpecialHeight.constant = 0
            self.view.layoutIfNeeded()
        }
        
        self.viewBackrestSizeHeight.constant = 45
        self.btnBackrestSizeHeight.constant = 30
        self.bottomViewHeight.constant = 0
        
        self.view.layoutIfNeeded()
        setClickable()
        
        
        
    }

    func showToastLocal(message : String) {


        self.lblError.isHidden = false
       // self.lblError.constant = 40
        self.lblError.numberOfLines = 0
        self.lblError.textColor = UIColor.red
        self.lblError.textAlignment = .center;
        self.lblError.font = UIFont(name: "Roboto", size: 16.0)
        self.lblError.text = message
        self.lblError.alpha = 1.0
        self.lblError.layer.cornerRadius = 10;
        self.lblError.clipsToBounds  =  true

        self.lblErrorSub.isHidden = false
        // self.lblError.constant = 40
        self.lblErrorSub.numberOfLines = 0
        self.lblErrorSub.textColor = UIColor.red
        self.lblErrorSub.textAlignment = .center;
        self.lblErrorSub.font = UIFont(name: "Roboto", size: 16.0)
        self.lblErrorSub.text = message
        self.lblErrorSub.alpha = 1.0
        self.lblErrorSub.layer.cornerRadius = 10;
        self.lblErrorSub.clipsToBounds  =  true

        //self.view.addSubview(self.lblShowError)
        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseOut, animations: {
            self.lblError.alpha = 0.0
            self.lblErrorSub.alpha = 0.0
        }, completion: {(isCompleted) in
            //self.lblShowError.removeFromSuperview()

            self.lblError.isHidden = true
            self.lblErrorSub.isHidden = true
            //self.lblErrorHeight.constant = 0

        })
    }

    
    @objc func rightButtonClicked(_ sender: Any) {
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print(sender.view?.tag ?? "")
        let i = sender.view?.tag ?? 0
        self.arrIteam = self.arrQuesOfModifiy![i].options
        self.index = i
        
        if index == 0 {
            
        
                let indexArray = self.arrIteam?.index(where: { $0 == "(GU) GoodFit Upholstered Back"})
                if indexArray != nil {
                    self.arrIteam?.remove(at: indexArray!)
                    self.arrIteam?.append("(GU) GoodFit Upholstered Back" + " " + "*")
                }
            
            }else if index == 2 {
            
            
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.backrestSizeValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.backrestSizeValue + " " + "*")
            }
            
            
            
            
        }
            
            
        else if index == 4 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.theighBredthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.theighBredthValue + " " + "*")
            }
            
        }
            
            
        else if index == 6 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.lowerLegLengthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.lowerLegLengthValue + " " + "*")
            }
            
        }
            
        else if index == 7 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.armrestUprightValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.armrestUprightValue + " " + "*")
            }
            
        }     else if index == 8 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.armrestCapValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.armrestCapValue + " " + "*")
            }
            
        }else if index == 1 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.controlValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.controlValue + " " + "*")
            }
        }
           
        else if index == 9 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.elbowHeightValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.elbowHeightValue + " " + "*")
            }
        }else if index == 12 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.caster})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.caster + " " + "*")
            }
        }
        
        
      
    
        if index == 0{
            if successDataObject.backrestSize == "4"{
                self.showToastLocal(message: "Sorry, you cannot change your mesh.")
            }else if isBackRestFour == true{
                self.showToastLocal(message: "Sorry, you cannot change your mesh")
            }else{
                  showPicker()
            }
        }else if index == 3 {
            
         
            if isMesh == true{
                self.showToastLocal(message: "Sorry, you cannot change your backrest add ones")
            }else{
                if successDataObject.backrestSize == "4"{
                    self.arrIteam?.append("Headrest")
                }
                self.setTableView()
            }
            
           
        }else if index == 5 {
            self.lblSeatOption.numberOfLines = 0
            
            
            self.setTableView()
        }else if index == 4 {
            
              if successDataObject.backrestSize == "4"{
                 self.showToastLocal(message: "Sorry, you cannot change your seatsize")
              }else if isBackRestFour == true{
                self.showToastLocal(message: "Sorry, you cannot change your seat size")
              }else{
                showPicker()
            }
        }else  if index == 2{
            if successDataObject.backrestSize == "4"{
                self.showToastLocal(message: "Sorry, you cannot change your backrest size.")
            }else {
                if isMesh == true{
                    self.showToastLocal(message: "Sorry, you cannot change your backrest size.")
                }else{
                    showPicker()
                }
            }
        }
            
        
        else{
           
             showPicker()
           
            
           
        }
        
        
    }
    
    func clickOnlable(lbl:UILabel,index:Int){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(tap)
        lbl.tag = index
        
        
    }
    
    func setClickable(){
        self.clickOnlable(lbl: lblBackrestPosition, index: 3)
        self.clickOnlable(lbl: lblMesh, index: 0)
        self.clickOnlable(lbl: lblSeatHieght, index: 6)
        self.clickOnlable(lbl: lblSeatSize, index: 4)
        self.clickOnlable(lbl: lblCantrol, index: 1)
        self.clickOnlable(lbl: lblbackRestSize, index: 2)
        self.clickOnlable(lbl: lblArmrests, index: 7)
        self.clickOnlable(lbl: lblArmcap, index: 8)
        self.clickOnlable(lbl: lblArmrestOption, index: 9)
        self.clickOnlable(lbl: lblBase, index: 10)
        self.clickOnlable(lbl: lblCasters, index: 12)
        self.clickOnlable(lbl: lblFootrest, index: 11)
        self.clickOnlable(lbl: lblSeatOption, index: 5)
        self.clickOnlable(lbl: lblSeatDepth, index: 13)
        self.clickOnlable(lbl: lblSeatAngle, index: 14)
    }
    
    
    func setSlectedValue(){
        
        self.lblMeshQue.text = arrQuesOfModifiy![0].question
        self.lblControllQue.text = " "+arrQuesOfModifiy![1].question
        self.lblbackrestsizeQue.text = arrQuesOfModifiy![2].question
        self.lblBackrestOption.text = arrQuesOfModifiy![3].question
        self.lblSeatsizeQue.text = arrQuesOfModifiy![4].question
        self.lblSeatsizeOptionsQue.text = arrQuesOfModifiy![5].question
        self.lblSeatheightQue.text = arrQuesOfModifiy![6].question
        self.lblArmrestQue.text = arrQuesOfModifiy![7].question
        self.lblArmrestCapQue.text = arrQuesOfModifiy![8].question
        self.lblArrestHeightQue.text = arrQuesOfModifiy![9].question
        self.lblBaseQue.text = arrQuesOfModifiy![10].question
        self.lblFootrestQue.text = arrQuesOfModifiy![11].question
        self.lblCastersQue.text = arrQuesOfModifiy![12].question
        self.lblSeatDepthQue.text = arrQuesOfModifiy![13].question
        self.lblSeatAngleQue.text = arrQuesOfModifiy![14].question
        
        if dicSelected["backrestOptions"] != nil{
            let  array = [dicSelected["backrestOptions"]] as! [String]
            let string = array.joined(separator: ",")
            if string == "" {
                 self.lblBackrestPosition.text  = "No Change"
            }else{
                 self.lblBackrestPosition.text  = string + " " + "*"
            }
            
           
        }else{
            dicSelected["backrestOptions"] = ""
        }
        if dicSelected["seatOptions"] != nil{
            let  array = [dicSelected["seatOptions"]] as! [String]
            let string = array.joined(separator: ",")
            
            if string == "" {
                self.lblSeatOption.text  = "No Change"
            }else{
               // self.lblSeatOption.text  = string + " " + "*"
                self.lblSeatOption.text  = string
            }
            
            //self.lblSeatOption.text  = string + " " + "*"
        }else{
            dicSelected["seatOptions"] = ""
        }
        if dicSelected["mesh"] as? String != nil {

            self.lblMesh.text = (dicSelected["mesh"] as? String)!
        }else{

            self.lblMesh.text = "(GU) GoodFit Upholstered Back"
            dicSelected["mesh"] = "(GU) GoodFit Upholstered Back"
        }
        if let armrestUprightValue = successDataObject.armrestUprightValue  {
            dicSelected["armrests"] = successDataObject.armrestUprightValue
           // self.lblArmrests.text = successDataObject.armrestUprightValue + " " + "*"
             self.lblArmrests.text = successDataObject.armrestUprightValue
            
        } else if dicSelected["armrests"] != nil{
            
            
            if (dicSelected["armrests"] as? String)! == "No Change" {
                self.lblArmrests.text  = "No Change"
            }else{
               // self.lblArmrests.text = (dicSelected["armrests"] as? String)! + " " + "*"
                 self.lblArmrests.text = (dicSelected["armrests"] as? String)!
            }
            
           
            
        }else{
            self.lblArmrests.text = "No Change"
            dicSelected["armrests"] = "No Change"
        }
        if successDataObject.controlValue != "" {
            dicSelected["control"] = successDataObject.controlValue
            //self.lblCantrol.text = successDataObject.controlValue + " " + "*"
            self.lblCantrol.text = successDataObject.controlValue
        } else{
            self.lblCantrol.text = "No Change"
            dicSelected["control"] = "No Change"
        }
        if successDataObject.caster != "" {
            dicSelected["casters"] = successDataObject.caster
            //self.lblCantrol.text = successDataObject.controlValue + " " + "*"
            self.lblCasters.text = successDataObject.caster
        }else if dicSelected["casters"] as? String != nil {
            
            if (dicSelected["casters"] as? String)! == "No Change" {
                self.lblCasters.text  = "No Change"
            }else{
                // self.lblCasters.text = (dicSelected["casters"] as? String)! + " " + "*"
                self.lblCasters.text = (dicSelected["casters"] as? String)!
            }
            
            
            
          
        }else{
            self.lblCasters.text  = "No Change"
            dicSelected["casters"] = "No Change"
        }
        
        if dicSelected["footrest"] as? String != nil {
            if (dicSelected["footrest"] as? String)! == "No Change" {
                self.lblFootrest.text  = "No Change"
            }else{
                //self.lblFootrest.text = (dicSelected["footrest"] as? String)! + " " + "*"
                self.lblFootrest.text = (dicSelected["footrest"] as? String)!
            }
            
           
        }else{
            self.lblFootrest.text = "No Change"
            dicSelected["footrest"] = "No Change"
        }
        if dicSelected["base"] as? String != nil {
            
            if (dicSelected["base"] as? String)! == "No Change" {
                self.lblBase.text  = "No Change"
            }else{
              //  self.lblBase.text = (dicSelected["base"] as? String)! + " " + "*"
                 self.lblBase.text = (dicSelected["base"] as? String)!
            }
            
            
           
        }else{
            self.lblBase.text = "No Change"
            dicSelected["base"] = "No Change"
        }
        
        if successDataObject.armrestCapValue != "" {
            dicSelected["armcap"] = successDataObject.armrestCapValue
           // self.lblArmcap.text = successDataObject.armrestCapValue + " " + "*"
            self.lblArmcap.text = successDataObject.armrestCapValue
        } else if dicSelected["armcap"] as? String != nil {
            
            if (dicSelected["armcap"] as? String)! == "No Change" {
                self.lblArmcap.text  = "No Change"
            }else{
                 //self.lblArmcap.text = (dicSelected["armcap"] as? String)! + " " + "*"
                self.lblArmcap.text = (dicSelected["armcap"] as? String)!
            }
            
           
        }else{
            self.lblArmcap.text = "No Change"
            dicSelected["armcap"] = "No Change"
        }
        
        if successDataObject.lowerLegLengthValue != "" {
            dicSelected["seatHieght"] = successDataObject.lowerLegLengthValue
           // self.lblSeatHieght.text = successDataObject.lowerLegLengthValue + " " + "*"
             self.lblSeatHieght.text = successDataObject.lowerLegLengthValue
        } else if dicSelected["seatHieght"] != nil{
            
            if (dicSelected["seatHieght"] as? String)! == "No Change" {
                self.lblSeatHieght.text  = "No Change"
            }else{
               //  self.lblSeatHieght.text = (dicSelected["seatHieght"] as? String)! + " " + "*"
                self.lblSeatHieght.text = (dicSelected["seatHieght"] as? String)!
            }
            
            
          
            
        }else{
            self.lblSeatHieght.text = "No Change"
            dicSelected["seatHieght"] = "No Change"
        }
                if successDataObject.upperLegLengthValue != "" {
                    dicSelected["seatDepth"] = successDataObject.upperLegLengthValue
                    self.lblSeatDepth.text = successDataObject.upperLegLengthValue
                } else if dicSelected["seatDepth"] != nil{
                    self.lblSeatDepth.text = dicSelected["seatDepth"] as? String
        
                }else{
                    self.lblSeatDepth.text = "No Change"
                    dicSelected["seatDepth"] = "No Change"
                }
        if successDataObject.theighBredthValue != "" {
            dicSelected["seatSize"] = successDataObject.theighBredthValue
            //self.lblSeatSize.text = successDataObject.theighBredthValue  + " " + "*"
            self.lblSeatSize.text = successDataObject.theighBredthValue
        } else if dicSelected["seatSize"] != nil{
            
            if (dicSelected["seatSize"] as? String)! == "No Change" {
                self.lblSeatSize.text  = "No Change"
            }else{
               // self.lblSeatSize.text = (dicSelected["seatSize"] as? String)!  + " " + "*"
                self.lblSeatSize.text = (dicSelected["seatSize"] as? String)!
            }
            
           
            
        }else{
            self.lblSeatSize.text = "No Change"
            dicSelected["seatSize"] = "No Change"
        }
        if successDataObject.backrestSizeValue != "" {

            if self.lblMesh.text == "(GM) GoodFit Mesh Back"{
                self.lblbackRestSize.text = "(3) Upholstered High Back - 23”h x 19”w"
                 dicSelected["backrestSize"] = "(3) Upholstered High Back - 23”h x 19”w"
            }else{
                 dicSelected["backrestSize"] = successDataObject.backrestSizeValue
                self.lblbackRestSize.text = successDataObject.backrestSizeValue
            }

        } else if dicSelected["backrestSize"] != nil{
            
            if (dicSelected["backrestSize"] as? String)! == "No Change" {
                self.lblbackRestSize.text  = "No Change"
            }else{
              //  self.lblbackRestSize.text = (dicSelected["backrestSize"] as? String)!  + " " + "*"
                 self.lblbackRestSize.text = (dicSelected["backrestSize"] as? String)!
            }
            
            
            
        }else{
            self.lblbackRestSize.text = "No Change"
            dicSelected["backrestSize"] = "No Change"
        }
                if dicSelected["seatAngle"] as? String != nil {
                    self.lblSeatAngle.text = dicSelected["seatAngle"] as? String
                }else{
                    self.lblSeatAngle.text = "No Change"
                    dicSelected["seatAngle"] = "No Change"
                }
        if successDataObject.elbowHeightValue != "" {
            dicSelected["armrestOption"] = successDataObject.elbowHeightValue
           // self.lblArmrestOption.text = successDataObject.elbowHeightValue + " " + "*"
            self.lblArmrestOption.text = successDataObject.elbowHeightValue
        }else if dicSelected["armrestOption"] as? String != nil {
            
            if (dicSelected["armrestOption"] as? String)! == "No Change" {
                self.lblArmrestOption.text  = "No Change"
            }else{
                 //self.lblArmrestOption.text = (dicSelected["armrestOption"] as? String)!   + " " + "*"
                self.lblArmrestOption.text = (dicSelected["armrestOption"] as? String)!
            }
            
           
        }else{
            self.lblArmrestOption.text = "No Change"
            dicSelected["armrestOption"] = "No Change"
        }
        
        
   
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false

        imageBanner.kf.indicatorType = .activity
        let urlbaner = URL(string: imgBaseUrl)
        imageBanner.kf.setImage(with: urlbaner)
        imgBannerSecond.kf.indicatorType = .activity
       
        imgBannerSecond.kf.setImage(with: urlbaner)
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
      
//        UIView().setShadowImg(self.imgBanner)
        
        UIView().setShadow(self.viewFirstCantainer)
        UIView().setShadow(self.viewSecondContainer)

        UIView().setShadowImg(self.imageBanner)
         UIView().setShadowImg(imgBannerSecond);
        if let viewone = self.view.viewWithTag(22),let viewTwo = self.view.viewWithTag(21),let viewThree = self.view.viewWithTag(23),let viewFour = self.view.viewWithTag(24),let viewFive = self.view.viewWithTag(25),let viewsix = self.view.viewWithTag(26),let viewSeven = self.view.viewWithTag(27),let viewEight = self.view.viewWithTag(28) {
             UIView().setShadow(viewone);
            UIView().setShadow(viewTwo);
             UIView().setShadow(viewThree);
             UIView().setShadow(viewFour);
            UIView().setShadow(viewFive);
             UIView().setShadow(viewsix);
                             UIView().setShadow(viewSeven);
             UIView().setShadow(viewEight);
        }


        if let viewone = self.view.viewWithTag(11),let viewTwo = self.view.viewWithTag(12),let viewThree = self.view.viewWithTag(13),let viewFour = self.view.viewWithTag(14),let viewFive = self.view.viewWithTag(15),let viewsix = self.view.viewWithTag(16),let viewSeven = self.view.viewWithTag(17) {
            UIView().setShadow(viewone);
            UIView().setShadow(viewTwo);
            UIView().setShadow(viewThree);
            UIView().setShadow(viewFour);
            UIView().setShadow(viewFive);
            UIView().setShadow(viewsix);
            UIView().setShadow(viewSeven);
          
        }

        if device.diagonal == 4{
            self.imgConstraintTopHeight.constant = 25.0
            self.imgSecondConstHeight.constant = 25.0
        }else   if device.diagonal == 4.7{
             self.imgConstraintTopHeight.constant = 30.0
            self.imgSecondConstHeight.constant = 30.0

        }else   if device.diagonal == 5.5{
            self.imgConstraintTopHeight.constant = 35.0
            self.imgSecondConstHeight.constant = 35.0

        }
        else {
            self.imgConstraintTopHeight.constant = 40.0
            self.imgSecondConstHeight.constant = 40.0


        }
//
    }
    
    
    @IBAction func clickToinfo(_ sender: Any) {
        self.showToastLocal(message: "No Change Options from picker")
    }
    
    
    
    
    func setTableView(){
        
        let toolBar = UIToolbar().ToolbarTable(mySelect: #selector(self.donedatePicker),myCancle:#selector(self.cancleTable))
        self.tableView.tableHeaderView = toolBar
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    
    
    
    func showPicker(){
        
        
        
        
        
        if  textField == nil {
            
            self.textField = UITextField(frame:.zero)
            textField.inputView = self.pickerView
            self.view.addSubview(textField)
            
        }
        
        
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        textField.inputAccessoryView = toolBar
        textField.becomeFirstResponder()
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
        
    }
    
    @objc func cancleTable(){
        if index == 3{
            self.lblBackrestPosition.text  = "No Change"
            dicSelected["backrestOptions"] = "No Change"
            self.tableView.isHidden = true
        }else if index == 5{
            self.lblSeatOption.text  = "No Change"
            dicSelected["seatOptions"] = "No Change"
            self.tableView.isHidden = true
        }
    }
    
    @objc func donedatePicker(){
        
        if index == 2{
            if strValue == "Default value"{
                //self.lblbackRestSize.text   = successDataObject.backrestSizeValue + " " + "*"
                 self.lblbackRestSize.text   = successDataObject.backrestSizeValue
                dicSelected["backrestSize"] = successDataObject.backrestSizeValue
            }else{
                self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                                   options: NSString.CompareOptions.literal, range:nil)
                
                if strValue == "No Change"{
                    self.lblbackRestSize.text  = strValue
                }else{
                   // self.lblbackRestSize.text = strValue + " " + "*"
                     self.arrIteam = arrQuesOfModifiy![index].options
                    
                    if strValue == arrIteam?.last{
                        self.isBackRestFour = true
                          self.arrIteam = arrQuesOfModifiy![index].options
                        self.lblSeatSize.text = arrIteam?.last
                    }else{
                            self.isBackRestFour = false
                    }
                    
                    self.lblbackRestSize.text = strValue
                }
                
                
                //self.lblbackRestSize.text   = strValue + " " + "*"
                dicSelected["backrestSize"] = strValue
            }
            
            
            
            
            
        }else if index == 4{
            
            
            if strValue == "Default value"{
                self.lblSeatSize.text  = successDataObject.theighBredthValue + " " + "*"
                dicSelected["seatSize"] = successDataObject.theighBredthValue
            }else{
                self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                                   options: NSString.CompareOptions.literal, range:nil)
                if strValue == "No Change"{
                    self.lblSeatSize.text  = strValue
                }else{
                   // self.lblSeatSize.text = strValue + " " + "*"
                    self.lblSeatSize.text = strValue
                }
               // self.lblSeatSize.text  = strValue + " " + "*"
                dicSelected["seatSize"] = strValue
            }
            
            
            
            
        }else if index == 3{
          
                let string = selectedOptions.joined(separator: ",")
                dicSelected["backrestOptions"] = string
                
                if string == ""{
                    self.lblBackrestPosition.text  = "No Change"
                }else{
                  //  self.lblBackrestPosition.text = string + " " + "*"
                     self.lblBackrestPosition.text = string
                }
                
                //  self.lblBackrestPosition.text  = string + " " + "*"
                self.selectedOptions.removeAll()
                self.tableView.isHidden = true
            
            
            
            
      
        }else if index == 5{
            let string = selectedOptions.joined(separator: ",")
            dicSelected["seatOptions"] = string
            
            if string == ""{
                self.lblSeatOption.text  = "No Change"
            }else{
               // self.lblSeatOption.text = string + " " + "*"
                self.lblSeatOption.text = string
            }
            
         //   self.lblSeatOption.text  = string + " " + "*"
            self.selectedOptions.removeAll()
            self.tableView.isHidden = true
        }else if index == 6{
            
            
            if strValue == "Default value"{
               // self.lblSeatHieght.text  = successDataObject.lowerLegLengthValue + " " + "*"
                self.lblSeatHieght.text  = successDataObject.lowerLegLengthValue
                dicSelected["seatHieght"] = successDataObject.lowerLegLengthValue
            }else{
                self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                                   options: NSString.CompareOptions.literal, range:nil)
                if strValue == "No Change"{
                    self.lblSeatHieght.text  = strValue
                }else{
                  //  self.lblSeatHieght.text = strValue + " " + "*"
                    self.lblSeatHieght.text = strValue
                }
                
                //self.lblSeatHieght.text  = strValue + " " + "*"
                dicSelected["seatHieght"] = strValue
            }
            
            
        }else if index == 7{
            
            
            
           
            
            
            if strValue == "Default value"{
               // self.lblArmrests.text  = successDataObject.armrestUprightValue + " " + "*"
                self.lblArmrests.text  = successDataObject.armrestUprightValue
                dicSelected["armrests"] = successDataObject.armrestUprightValue
            }else{
                self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                                   options: NSString.CompareOptions.literal, range:nil)
                if strValue == "No Change"{
                    self.lblArmrests.text  = strValue
                }else{
                   // self.lblArmrests.text = strValue + " " + "*"
                     self.lblArmrests.text = strValue
                }
                
              //  self.lblArmrests.text  = strValue + " " + "*"
                dicSelected["armrests"] = strValue
            }
            
            
        }else if index == 8{
            
            if strValue == "Default value"{
               // self.lblArmcap.text  = successDataObject.armrestCapValue + " " + "*"
                
                self.lblArmcap.text  = successDataObject.armrestCapValue
                dicSelected["armcap"] = successDataObject.armrestCapValue
            }else{
                self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                                   options: NSString.CompareOptions.literal, range:nil)
                if strValue == "No Change"{
                    self.lblArmcap.text  = strValue
                }else{
                    self.lblArmcap.text = strValue + " " + "*"
                }
                
                //self.lblArmcap.text  = strValue + " " + "*"
                dicSelected["armcap"] = strValue
            }
        }else if index == 10{
            
            if strValue == "No Change"{
                self.lblBase.text  = strValue
            }else{
                self.lblBase.text = strValue
                //self.lblBase.text = strValue + " " + "*"
            }
            //self.lblBase.text  = strValue + " " + "*"
            dicSelected["base"] = strValue
        }else if index == 11{
            
            if strValue == "No Change"{
                self.lblFootrest.text  = strValue
            }else{
                 self.lblFootrest.text = strValue
              //  self.lblFootrest.text = strValue + " " + "*"
            }
           // self.lblFootrest.text  = strValue + " " + "*"
            dicSelected["footrest"] = strValue
        }else if index == 12{
            self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                               options: NSString.CompareOptions.literal, range:nil)
            
            if strValue == "No Change"{
                self.lblCasters.text  = strValue
            }else{
                 self.lblCasters.text = strValue
               // self.lblCasters.text = strValue + " " + "*"
            }
            
          //  self.lblCasters.text = strValue + " " + "*"
            dicSelected["casters"] = strValue
        }else if index == 0{
            
            self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                               options: NSString.CompareOptions.literal, range:nil)
            
          // self.lblMesh.text  = strValue + " " + "*"
             self.lblMesh.text  = strValue
            self.arrIteam = arrQuesOfModifiy![index].options
            
            if strValue == arrIteam?.first{
                self.isMesh = true
                  self.arrIteam = arrQuesOfModifiy![2].options
                
                self.lblbackRestSize.text = self.arrIteam?[3]
                 dicSelected["backrestSize"] = self.arrIteam?[3]
                
            }else{
                
                self.isMesh = false
                 self.lblbackRestSize.text = successDataObject.backrestSizeValue

            }
            
            dicSelected["mesh"] = strValue
        }else if index == 1{
            
            if strValue == "Default value"{
                //self.lblCantrol.text  = successDataObject.controlValue + " " + "*"
                self.lblCantrol.text  = successDataObject.controlValue
                dicSelected["control"] = successDataObject.controlValue
            }else{
                self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                                   options: NSString.CompareOptions.literal, range:nil)
                
                if strValue == "No Change"{
                    self.lblCantrol.text  = strValue
                }else{
                  // self.lblCantrol.text = strValue + " " + "*"
                    self.lblCantrol.text = strValue
                }
                
              
                dicSelected["control"] = strValue
            }
            
            
            
        }
        else if index == 9{
            
            if strValue == "Default value"{
               // self.lblArmrestOption.text  = successDataObject.elbowHeightValue + " " + "*"
                self.lblArmrestOption.text  = successDataObject.elbowHeightValue
                dicSelected["armrestOption"] = successDataObject.elbowHeightValue
            }else{
                self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                                   options: NSString.CompareOptions.literal, range:nil)
                
                if strValue == "No Change"{
                     self.lblArmrestOption.text  = strValue
                }else{
                  //self.lblArmrestOption.text  = strValue + " " + "*"
                    self.lblArmrestOption.text  = strValue
                }
                
                dicSelected["armrestOption"] = strValue
            }
            
            
        } else if index == 13 {
            self.strValue = self.strValue.replacingOccurrences(of: "*", with: "",
                                                               options: NSString.CompareOptions.literal, range:nil)
            if strValue == "No Change"{
                self.lblSeatDepth.text  = strValue
            }else{
                //self.lblSeatDepth.text  = strValue + " " + "*"
                self.lblSeatDepth.text  = strValue
            }
            dicSelected["seatDepth"] = strValue
        } else if index == 14 {
            if strValue == "No Change"{
                self.lblSeatAngle.text  = strValue
            }else{
               // self.lblSeatAngle.text  = strValue + " " + "*"
                self.lblSeatAngle.text  = strValue
            }
            dicSelected["seatAngle"] = strValue
        }
        
        
        
        self.view.endEditing(true)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func setShadow(_ view: UIButton){
        
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        
        
    }
    
    
    @IBAction func clickToPickerOpen(_ sender: Any) {
        //  self.pickerView.reloadAllComponents()
        
        index = (sender as AnyObject).tag
        
        self.arrIteam = arrQuesOfModifiy![index].options
        
        if index == 2 {
            
          
                let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.backrestSizeValue})
                if indexArray != nil {
                    self.arrIteam?.remove(at: indexArray!)
                    self.arrIteam?.append(successDataObject.backrestSizeValue + " " + "*")
                }
            
            
       
            
        }
            
        if index == 13 {
            
            
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.upperLegLengthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.upperLegLengthValue + " " + "*")
            }
            
            
            
            
        }
            
            
            
        else if index == 4 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.theighBredthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.theighBredthValue + " " + "*")
            }
            
        }
            
            
        else if index == 6 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.lowerLegLengthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.lowerLegLengthValue + " " + "*")
            }
            
        }
            
        else if index == 7 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.armrestUprightValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.armrestUprightValue + " " + "*")
            }
            
        }     else if index == 8 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.armrestCapValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.armrestCapValue + " " + "*")
            }
            
        }else if index == 1 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.controlValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.controlValue + " " + "*")
            }
        }
            //else if index == 12 {
            //            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.upperLegLengthValue})
            //            if indexArray != nil {
            //                self.arrIteam?.remove(at: indexArray!)
            //                self.arrIteam?.append("Default value")
            //            }
            //        }
        else if index == 9 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.elbowHeightValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.elbowHeightValue + " " + "*")
            }
        }else if index == 12 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.caster})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append(successDataObject.caster + " " + "*")
            }
        }
        
        
        
        
        
        self.strValue = ""
        
        if index == 3 {
            
            if successDataObject.backrestSize == "4"{
                self.arrIteam?.append("Headrest")
            }
            
            if isMesh == true{
                self.showToastLocal(message: "Sorry, you cannot change your backrest add ones")
            }else{
               self.setTableView()
            }
            
            
        }else if index == 5 {
            self.lblSeatOption.numberOfLines = 0
            
            
            self.setTableView()
        } else if index == 0 {
            if successDataObject.backrestSize == "4"{
                self.showToastLocal(message: "Sorry, you cannot change your mesh.")
            }else if isBackRestFour == true{
                self.showToastLocal(message: "Sorry, you cannot change your mesh")
            }else {
                
                let indexArray = self.arrIteam?.index(where: { $0 == "(GU) GoodFit Upholstered Back"})
                if indexArray != nil {
                    self.arrIteam?.remove(at: indexArray!)
                    self.arrIteam?.append("(GU) GoodFit Upholstered Back" + " " + "*")
                }
                showPicker()
//                if isMesh == true{
//                    self.viewBackrestSizeHeight.constant = 0
//                    self.btnBackrestSizeHeight.constant = 0
//                    self.view.layoutIfNeeded()
//                    showPicker()
//                }else{
//                    self.viewBackrestSizeHeight.constant = 45
//                    self.btnBackrestSizeHeight.constant = 30
//                    self.view.layoutIfNeeded()
//                    showPicker()
//                }
            }
            
            
  
        }else{
            if index == 2{
                if successDataObject.backrestSize == "4"{
                    self.showToastLocal(message: "Sorry, you cannot change your backrest size.")
                }else {
                    if isMesh == true{
                         self.showToastLocal(message: "Sorry, you cannot change your backrest size.")
                    }else{
                        showPicker()
                    }
                }
            }else if index == 4{
                if successDataObject.backrestSize == "4"{
                    self.showToastLocal(message: "Sorry, you cannot change your seat size")
                }else if isBackRestFour == true{
                      self.showToastLocal(message: "Sorry, you cannot change your seat size")
                }
                else {
                    showPicker()
                }
                
            } else{
                 showPicker()
            }
            
           
        }
        
        
        
        
        
    }
    
    
    func setPriorty(){
        
    }
    
    
    
    @IBAction func clickToSubview(_ sender: Any) {
        self.viewSub.frame = self.view.bounds
        self.view.addSubview(self.viewSub)
    }
    
    
    @IBAction func clickToRemoveSub(_ sender: Any) {
        self.viewSub.removeFromSuperview()
    }
    
    
    @IBAction func clickToNext(_ sender: Any) {
        
        
    }
    
    
    @IBAction func clickToPrevious(_ sender: Any) {
        
        self.delegate?.setDataOnPrevious(dicValue: dicSelected)
        
        self.navigationController?.popViewController(animated: true)
        
        
        
        
    }
    @IBAction func clickToCancle(_ sender: Any) {
        
        
        _ = SweetAlert().showAlert("Cancel Evaluation?", subTitle: "Are you sure you want to cancel?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                
            }
            else {
                
                let vc = SHomeVC(nibName: "SHomeVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    
    
    
    
}

extension ModifyModel : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
        return arrIteam!.count
        
        
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        
        return arrIteam?[row]
        
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        self.strValue = (arrIteam?[row])!
        
        
        
        
        
        
        
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        
        
        
        
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Roboto-Regular", size: 20)
            pickerLabel?.textAlignment = .center
            pickerLabel?.numberOfLines = 0
        }
        pickerLabel?.text = (arrIteam?[row] as? String)!
        pickerLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        return pickerLabel!
        
        
        
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if index == 1 || index == 8 || index == 12 || index == 6 || index == 3 || index == 4 {
            return 100.0
        }else{
            return 50.0
        }
        
    }
}




extension ModifyModel: UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(5)
        self.pickerView.reloadAllComponents()
    }
    
    
    
}


extension ModifyModel : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrIteam?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = arrIteam?[indexPath.row]
        
        if self.selectedOptions.index(of: arrIteam?[indexPath.row] as! String) != nil {
            cell?.accessoryType = .checkmark
            
        }else{
            cell?.accessoryType = .none
            
        }
        
        
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        if let index = self.selectedOptions.index(of: arrIteam?[indexPath.row] as! String){
            self.selectedOptions.remove(at: index)
            selectedCell?.accessoryType = .none
        }else{
            selectedCell?.accessoryType = .checkmark
            self.selectedOptions.append(arrIteam?[indexPath.row] as! String)
        }
        
        
        
        print(indexPath.row)
    }
}



