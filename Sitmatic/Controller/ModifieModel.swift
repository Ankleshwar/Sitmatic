//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class ModifieModel: BaseViewController {
    @IBOutlet weak var viewControl: UIView!
    @IBOutlet weak var viewBacrestSize: UIView!
    @IBOutlet weak var viewBackrestSizeHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
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
    var isMesh = true
    @IBOutlet weak var lblbackRestSize: UILabel!
    var count = 0
   var successDataObject : SuccessData!
    @IBOutlet weak var lblSeatDepth: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    var arrIteam :Array<Any>?
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
      
       // setSlectedValue()
        self.viewBackrestSizeHeight.constant = 0
        self.btnBackrestSizeHeight.constant = 0

            self.bottomViewHeight.constant = 0
        self.view.layoutIfNeeded()
        
        
    }
    
    
    

    
    
    func setSlectedValue(){
        dicSelected["backrestOptions"] = [""]
        dicSelected["seatOptions"] = [""]
        dicSelected["control"] = successDataObject.controlValue
        dicSelected["mesh"] = ""
        dicSelected["casters"] = ""
        dicSelected["footrest"] = ""
        dicSelected["base"] = ""
        dicSelected["armcap"] = ""
        dicSelected["armrests"] = successDataObject.elbowToElbowDistanceValue
        dicSelected["seatHieght"] = successDataObject.lowerLegLengthValue
        dicSelected["seatDepth"] = successDataObject.upperLegLengthValue
        dicSelected["seatSize"] = successDataObject.theighBredthValue
        dicSelected["backrestSize"] = successDataObject.backrestSizeValue
         self.lblbackRestSize.text = successDataObject.backrestSizeValue
        self.lblBackrestPosition.text = "Please select a value"
         self.lblSeatDepth.text = "Please select a value"
        self.lblSeatOption.text = "Please select a value"
        self.lblSeatHieght.text =  successDataObject.lowerLegLengthValue
        self.lblArmrests.text = "Please select a value"
        self.lblArmcap.text = "Please select a value"
        self.lblBase.text = "Please select a value"
        self.lblFootrest.text = "Please select a value"
        self.lblCasters.text  = "Please select a value"
        self.lblMesh.text = "Without Mesh"
        self.lblCantrol.text = successDataObject.controlValue
        self.lblSeatSize.text = successDataObject.theighBredthValue
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    @IBAction func clickToinfo(_ sender: Any) {
        self.showToast(message: "Please Select Options from picker")
    }
    
    
  
    
    func setTableView(){
      
         let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
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
    
    @objc func donedatePicker(){
        
        if index == 0{
            
        
            
            self.lblbackRestSize.text   = strValue
            dicSelected["backrestSize"] = strValue
            
            
        }else if index == 1{
          
            self.lblSeatSize.text  = strValue
             dicSelected["seatSize"] = strValue
            
        }else if index == 2{
            dicSelected["backrestOptions"] = self.selectedOptions
            let string = selectedOptions.joined(separator: " ")
            self.lblBackrestPosition.text  = string
            self.selectedOptions.removeAll()
            self.tableView.isHidden = true
        }else if index == 3{
            dicSelected["seatOptions"] = self.selectedOptions
            let string = selectedOptions.joined(separator: " ")
            self.lblSeatOption.text  = string
            self.selectedOptions.removeAll()
            self.tableView.isHidden = true
        }else if index == 4{
            self.lblSeatHieght.text  = strValue
             dicSelected["seatHieght"] = strValue
        }else if index == 5{
            self.lblArmrests.text  = strValue
              dicSelected["armrests"] = strValue
        }else if index == 6{
            self.lblArmcap.text  = strValue
             dicSelected["armcap"] = strValue
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
            self.lblCantrol.text = strValue
             dicSelected["control"] = strValue
        }else if index == 12{
            self.lblSeatDepth.text = strValue
            dicSelected["seatDepth"] = strValue
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
        self.strValue = ""
    
        if index == 2 {
            self.selectedOptions = dicSelected["backrestOptions"] as! [String]
            self.setTableView()
        }else if index == 3 {
            self.lblSeatOption.numberOfLines = 0
            self.selectedOptions = dicSelected["seatOptions"] as! [String]
            self.setTableView()
        } else if index == 0 {
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

extension ModifieModel : UIPickerViewDelegate,UIPickerViewDataSource{
    
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
        
        
        if index == 2 || index == 3{
            

           
            
           
        }else{
             self.strValue = (arrIteam?[row] as? String)!
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
        if index == 11 {
            return 85.0
        }else{
             return 40.0
        }
        
    }
}




extension ModifieModel: UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(5)
        self.pickerView.reloadAllComponents()
    }
    
    
    
}


extension ModifieModel : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrIteam?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = arrIteam?[indexPath.row] as? String
        
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


