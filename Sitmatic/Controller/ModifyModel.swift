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
    @IBOutlet weak var viewControl: UIView!
    @IBOutlet weak var viewBacrestSize: UIView!
    @IBOutlet weak var viewBackrestSizeHeight: NSLayoutConstraint!
    var delegate: ModifyModelDelegate?
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSeatAngle: UILabel!
    
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
    var dicSelected = Dictionary<String, Any>()
    var textField : UITextField!
    var imagViewForPicker = UIImageView()
    @IBOutlet var viewSub: UIView!
    @IBOutlet weak var lblQuestionValueCount: UILabel!
    var dicAnsData = Dictionary<String, String>()
    var strInce: String!
    @IBOutlet var pickerView: UIPickerView!
    var isMesh = false
    @IBOutlet weak var lblbackRestSize: UILabel!
    var count = 0
   var successDataObject : SuccessData!
    @IBOutlet weak var lblSeatDepth: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewControlHeight: NSLayoutConstraint!
    
    var arrIteam :Array<String>?
    @IBOutlet weak var lblQuestion: UILabel!
    var strValue: String = ""
   
 
    var arrAnswer = NSMutableArray()
    var serverArraySecond: [[String: String]]  = Array()
    var dicData = Dictionary<String, Any>()
    
    var ansStrIn: String!
    var isFirstQuestion: Bool!
    
     var arrSections = [Section]()
    var index = 100
    var arrQuestion: Array<Dictionary<String,Any>>?
    
    
    
    @IBAction func clickToDone(_ sender: Any) {
        print(dicSelected)
        let vc = OrderProccessingThird(nibName: "OrderProccessingThird", bundle: nil)
        vc.Modifie = "1"
        vc.dicServerSide = dicSelected
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBOutlet weak var tostView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        arrQuestion = (setDataWithLocalJson("ModifiModel") as NSArray as? Array<Dictionary<String, Any>>)!
        print(successDataObject)
      
       self.arrIteam = arrQuestion![0]["value"] as? Array
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = #colorLiteral(red: 0.8, green: 0.8117647059, blue: 0.8392156863, alpha: 1)
        self.tableView.isHidden = true
      
        
        setSlectedValue()
       
        
        self.viewBackrestSizeHeight.constant = 45
        self.btnBackrestSizeHeight.constant = 30
        self.bottomViewHeight.constant = 0

        self.view.layoutIfNeeded()
        
        
    }
    
    
    

    
    
    func setSlectedValue(){
      
        
        if dicSelected["backrestOptions"] != nil{
         let  array = [dicSelected["backrestOptions"]] as! [String]
            let string = array.joined(separator: ",")
            self.lblBackrestPosition.text  = string
        }else{
            dicSelected["backrestOptions"] = ""
        }
        if dicSelected["seatOptions"] != nil{
            let  array = [dicSelected["seatOptions"]] as! [String]
            let string = array.joined(separator: ",")
            self.lblSeatOption.text  = string
        }else{
            dicSelected["seatOptions"] = ""
        }
        if dicSelected["mesh"] as? String != nil {
            self.lblMesh.text = dicSelected["mesh"] as? String
        }else{
             self.lblMesh.text = "Without Mesh"
             dicSelected["mesh"] = "Without Mesh"
        }
        if successDataObject.armrestUprightValue != "" {
             dicSelected["armrests"] = successDataObject.armrestUprightValue
            self.lblArmrests.text = successDataObject.armrestUprightValue
        } else if dicSelected["armrests"] != nil{
            self.lblArmrests.text = dicSelected["armrests"] as? String
            
        }else{
            self.lblArmrests.text = "Please select "
            dicSelected["armrests"] = "Please select "
        }
        if successDataObject.controlValue != "" {
            dicSelected["control"] = successDataObject.controlValue
             self.lblCantrol.text = successDataObject.controlValue
        } else{
            self.lblCantrol.text = "Please select "
            dicSelected["control"] = "Please select "
        }
        if dicSelected["casters"] as? String != nil {
            self.lblCasters.text = dicSelected["casters"] as? String
        }else{
             self.lblCasters.text  = "Please select "
                dicSelected["casters"] = "Please select "
        }
        
        if dicSelected["footrest"] as? String != nil {
            self.lblFootrest.text = dicSelected["footrest"] as? String
        }else{
           self.lblFootrest.text = "Please select "
            dicSelected["footrest"] = "Please select "
        }
        if dicSelected["base"] as? String != nil {
            self.lblBase.text = dicSelected["base"] as? String
        }else{
            self.lblBase.text = "Please select "
            dicSelected["base"] = "Please select "
        }
        
        if successDataObject.armrestCapValue != "" {
            dicSelected["armcap"] = successDataObject.armrestCapValue
            self.lblArmcap.text = successDataObject.armrestCapValue
        } else if dicSelected["armcap"] as? String != nil {
            self.lblArmcap.text = dicSelected["armcap"] as? String
        }else{
             self.lblArmcap.text = "Please select "
            dicSelected["armcap"] = "Please select "
        }
        
        if successDataObject.lowerLegLengthValue != "" {
            dicSelected["seatHieght"] = successDataObject.lowerLegLengthValue
            self.lblSeatHieght.text = successDataObject.lowerLegLengthValue
        } else if dicSelected["seatHieght"] != nil{
            self.lblSeatHieght.text = dicSelected["seatHieght"] as? String
            
        }else{
            self.lblSeatHieght.text = "Please select "
            dicSelected["seatHieght"] = "Please select "
        }
        if successDataObject.upperLegLengthValue != "" {
            dicSelected["seatDepth"] = successDataObject.upperLegLengthValue
            self.lblSeatDepth.text = successDataObject.upperLegLengthValue
        } else if dicSelected["seatDepth"] != nil{
            self.lblSeatDepth.text = dicSelected["seatDepth"] as? String
            
        }else{
            self.lblSeatDepth.text = "Please select "
            dicSelected["seatDepth"] = "Please select "
        }
        if successDataObject.theighBredthValue != "" {
            dicSelected["seatSize"] = successDataObject.theighBredthValue
            self.lblSeatSize.text = successDataObject.theighBredthValue
        } else if dicSelected["seatSize"] != nil{
            self.lblSeatSize.text = dicSelected["seatSize"] as? String
            
        }else{
            self.lblSeatSize.text = "Please select "
            dicSelected["seatSize"] = "Please select "
        }
        if successDataObject.backrestSizeValue != "" {
            dicSelected["backrestSize"] = successDataObject.backrestSizeValue
            self.lblbackRestSize.text = successDataObject.backrestSizeValue
        } else if dicSelected["backrestSize"] != nil{
            self.lblbackRestSize.text = dicSelected["backrestSize"] as? String
            
        }else{
            self.lblbackRestSize.text = "Please select "
            dicSelected["backrestSize"] = "Please select "
        }
        if dicSelected["seatAngle"] as? String != nil {
            self.lblSeatAngle.text = dicSelected["seatAngle"] as? String
        }else{
            self.lblSeatAngle.text = "Please select "
            dicSelected["seatAngle"] = "Please select "
        }
        if successDataObject.elbowHeightValue != "" {
            dicSelected["armrestOption"] = successDataObject.elbowHeightValue
            self.lblArmrestOption.text = successDataObject.elbowHeightValue
        }else if dicSelected["armrestOption"] as? String != nil {
            self.lblArmrestOption.text = dicSelected["armrestOption"] as? String
        }else{
            self.lblArmrestOption.text = "Please select "
            dicSelected["armrestOption"] = "Please select "
        }
   
       

      
        
       
      
       
       
       
        
      
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    @IBAction func clickToinfo(_ sender: Any) {
        self.showToast(message: "Please Select Options from picker")
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
        if index == 2{
            self.lblBackrestPosition.text  = "Please select"
            dicSelected["backrestOptions"] = "Please select"
            self.tableView.isHidden = true
        }else if index == 3{
            self.lblSeatOption.text  = "Please select"
            dicSelected["seatOptions"] = "Please select"
            self.tableView.isHidden = true
        }
    }
    
    @objc func donedatePicker(){
        
        if index == 0{
            if strValue == "Default value"{
                self.lblbackRestSize.text   = successDataObject.backrestSizeValue
                dicSelected["backrestSize"] = successDataObject.backrestSizeValue
            }else{
                self.lblbackRestSize.text   = strValue
                dicSelected["backrestSize"] = strValue
            }
        
            
           
            
            
        }else if index == 1{
            
            
            if strValue == "Default value"{
                self.lblSeatSize.text  = successDataObject.theighBredthValue
                dicSelected["seatSize"] = successDataObject.theighBredthValue
            }else{
                self.lblSeatSize.text  = strValue
                dicSelected["seatSize"] = strValue
            }
            
          
        
            
        }else if index == 2{
            
            let string = selectedOptions.joined(separator: ",")
            dicSelected["backrestOptions"] = string
            self.lblBackrestPosition.text  = string
            self.selectedOptions.removeAll()
            self.tableView.isHidden = true
        }else if index == 3{
             let string = selectedOptions.joined(separator: ",")
            dicSelected["seatOptions"] = string
           
            self.lblSeatOption.text  = string
            self.selectedOptions.removeAll()
            self.tableView.isHidden = true
        }else if index == 4{
            
            
            if strValue == "Default value"{
                self.lblSeatHieght.text  = successDataObject.lowerLegLengthValue
                dicSelected["seatHieght"] = successDataObject.lowerLegLengthValue
            }else{
                self.lblSeatHieght.text  = strValue
                dicSelected["seatHieght"] = strValue
            }
            
           
        }else if index == 5{
            
            if strValue == "Default value"{
                self.lblArmrests.text  = successDataObject.armrestUprightValue
                dicSelected["armrests"] = successDataObject.armrestUprightValue
            }else{
                self.lblArmrests.text  = strValue
                dicSelected["armrests"] = strValue
            }
            
     
        }else if index == 6{
            
            if strValue == "Default value"{
                self.lblArmcap.text  = successDataObject.armrestCapValue
                dicSelected["armrests"] = successDataObject.armrestCapValue
            }else{
            
                self.lblArmcap.text  = strValue
                dicSelected["armcap"] = strValue
            }
        }else if index == 7{
            self.lblBase.text  = strValue
             dicSelected["base"] = strValue
        }else if index == 8{
            self.lblFootrest.text  = strValue
            dicSelected["footrest"] = strValue
        }else if index == 9{
            self.lblCasters.text = strValue
            dicSelected["casters"] = strValue
        }else if index == 10{
            self.lblMesh.text  = strValue
            if self.lblMesh.text == "With Mesh"{
                self.isMesh = true
                self.viewBackrestSizeHeight.constant = 0
                self.btnBackrestSizeHeight.constant = 0

            
                self.view.layoutIfNeeded()
                }else{
                
                self.isMesh = false
                 self.viewBackrestSizeHeight.constant = 45
                self.btnBackrestSizeHeight.constant = 30

                self.view.layoutIfNeeded()
            }
            
            dicSelected["mesh"] = strValue
        }else if index == 11{
            
            if strValue == "Default value"{
                self.lblCantrol.text  = successDataObject.controlValue
                dicSelected["control"] = successDataObject.controlValue
            }else{
                self.lblCantrol.text = strValue
                dicSelected["control"] = strValue
            }
            
            
          
        }else if index == 12{
            
            if strValue == "Default value"{
                self.lblSeatDepth.text  = successDataObject.upperLegLengthValue
                dicSelected["seatDepth"] = successDataObject.upperLegLengthValue
            }else{
                self.lblSeatDepth.text = strValue
                dicSelected["seatDepth"] = strValue
            }
            
           
        }else if index == 13{
            self.lblSeatAngle.text  = strValue
            dicSelected["seatAngle"] = strValue
        }else if index == 14{
            
            if strValue == "Default value"{
                self.lblArmrestOption.text  = successDataObject.elbowHeightValue
                dicSelected["armrestOption"] = successDataObject.elbowHeightValue
            }else{
                self.lblArmrestOption.text  = strValue
                dicSelected["armrestOption"] = strValue
            }
            
            
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
     
        index = (sender as AnyObject).tag
        
        self.arrIteam = arrQuestion![index]["value"] as? Array
        
        if index == 0 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.backrestSizeValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
            
        }
        
        
       else if index == 1 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.theighBredthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
            
        }
        
        
        else if index == 4 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.lowerLegLengthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
            
        }
        
        else if index == 5 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.armrestUprightValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
            
        }     else if index == 6 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.armrestCapValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
            
        }else if index == 11 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.controlValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
        }else if index == 12 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.upperLegLengthValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
        }
        else if index == 14 {
            let indexArray = self.arrIteam?.index(where: { $0 == successDataObject.elbowHeightValue})
            if indexArray != nil {
                self.arrIteam?.remove(at: indexArray!)
                self.arrIteam?.append("Default value")
            }
        }
        
        
        
        
        
        self.strValue = ""
        
        if index == 10 {
            if successDataObject.backrestSize == "4"{
                self.showToast(message: "you can't select it")
            }else{
               showPicker()
            }
        }else  if index == 1 {
            
            
            if successDataObject.backrestSize == "4"{
                 self.showToast(message: "you can't select it")
            }else{
                  showPicker()
            }
            
            
        }
        
        
        else  if index == 2 {
        
            
            if successDataObject.backrestSize == "4"{
                self.arrIteam?.append("Headrest")
            }
            
            self.setTableView()
        }else if index == 3 {
            self.lblSeatOption.numberOfLines = 0
         
            
            self.setTableView()
        } else if index == 0 {
            if successDataObject.backrestSize == "4"{
               self.showToast(message: "you can't select it")
            }else{
                if isMesh == true{
                    self.viewBackrestSizeHeight.constant = 0
                    self.btnBackrestSizeHeight.constant = 0
                    self.view.layoutIfNeeded()
                }else{
                    self.viewBackrestSizeHeight.constant = 45
                    self.btnBackrestSizeHeight.constant = 30
                    self.view.layoutIfNeeded()
                    showPicker()
                }

            }
            
            
        }else{
            showPicker()
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
        
        
        _ = SweetAlert().showAlert("Confirm Cancellation", subTitle: "Are you sure you want to cancel this order?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
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
        
        
        if index == 2 || index == 3{
            

           
            
           
        }else{
            self.strValue = (arrIteam?[row])!
        }
        
  
       
        
        
        
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
        if index == 11 || index == 9 || index == 5 || index == 6 {
            return 95.0
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


