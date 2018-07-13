//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class ModifieModel: BaseViewController {
    
    @IBOutlet weak var lblSeatSize: UILabel!
    @IBOutlet weak var lblBackrestPosition: UILabel!
    @IBOutlet weak var lblArmrests: UILabel!
    @IBOutlet weak var lblArmcap: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblCasters: UILabel!
    @IBOutlet weak var lblFootrest: UILabel!
    @IBOutlet weak var lblMesh: UILabel!
    
    @IBOutlet weak var lblSeatHieght: UILabel!
    @IBOutlet weak var lblSeatOption: UILabel!
    @IBOutlet weak var lblCantrol: UILabel!
    
   var textField : UITextField!
    
    @IBOutlet var viewSub: UIView!
    @IBOutlet weak var lblQuestionValueCount: UILabel!
    var dicAnsData = Dictionary<String, String>()
    var strInce: String!
    @IBOutlet var pickerView: UIPickerView!

    @IBOutlet weak var lblbackRestSize: UILabel!
    var count = 0
   

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
        
        let vc = OrderProccessingThird(nibName: "OrderProccessingThird", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBOutlet weak var tostView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        arrQuestion = (setDataWithLocalJson("ModifiModel") as NSArray as? Array<Dictionary<String, Any>>)!
      
       self.arrIteam = arrQuestion![0]["value"] as? Array
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    @IBAction func clickToinfo(_ sender: Any) {
        self.showToast(message: "Please Select Options from picker")
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
            
            
        }else if index == 1{
          
            self.lblSeatSize.text  = strValue
            
        }else if index == 2{
            self.lblBackrestPosition.text  = strValue
        }else if index == 3{
            self.lblSeatOption.text  = strValue
        }else if index == 4{
            self.lblSeatHieght.text  = strValue
        }else if index == 5{
            self.lblArmrests.text  = strValue
        }else if index == 6{
            self.lblArmcap.text  = strValue
        }else if index == 7{
            self.lblBase.text  = strValue
        }else if index == 8{
            self.lblFootrest.text  = strValue
        }else if index == 9{
            self.lblCasters.text = strValue
        }else if index == 10{
            self.lblMesh.text  = strValue
        }else if index == 11{
            self.lblCantrol.text = strValue
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
         self.strValue = (arrIteam?[0] as? String)!
         showPicker()
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
        
        
  
        self.strValue = (arrIteam?[row] as? String)!
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
            pickerLabel?.textAlignment = .center
            pickerLabel?.numberOfLines = 0
        }
        pickerLabel?.text = (arrIteam?[row] as? String)!
        pickerLabel?.textColor = #colorLiteral(red: 0.06666666667, green: 0.6470588235, blue: 1, alpha: 1)
        
        return pickerLabel!
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if index == 11 {
            return 50.0
        }else{
            return 30.0
        }
        
    }
}




extension ModifieModel: UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(5)
        self.pickerView.reloadAllComponents()
    }
    
    
    
}

