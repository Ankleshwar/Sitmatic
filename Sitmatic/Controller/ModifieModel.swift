//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class ModifieModel: BaseViewController {
    
  
   
    @IBOutlet weak var txtBackrestSize: UITextField!
    
    @IBOutlet weak var lblQuestionValueCount: UILabel!
    var dicAnsData = Dictionary<String, String>()
    var strInce: String!
    @IBOutlet var pickerView: UIPickerView!

    @IBOutlet weak var lblbackRestSize: UILabel!
    var count = 0
   

    @IBOutlet weak var collectionView: UICollectionView!

    var arrIteam :Array<Any>?
    @IBOutlet weak var lblQuestion: UILabel!
    var strValue: String!
   
 
    var arrAnswer = NSMutableArray()
    var serverArraySecond: [[String: String]]  = Array()
    var dicData = Dictionary<String, Any>()
    
    var ansStrIn: String!
    var isFirstQuestion: Bool!
    
     var arrSections = [Section]()
    
    
    
    
    
    
    
    @IBOutlet weak var tostView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
       self.dicAnsData["selected"] = ""
       self.arrIteam = ["Low Back","Mid Back","High Back","High & Wide Back"]
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        showPicker()
        
    }
    
    
    
    func showPicker(){
        
       txtBackrestSize.inputView = pickerView
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtBackrestSize.inputAccessoryView = toolBar
        
        
    }
    
    @objc func donedatePicker(){
        
  
          self.txtBackrestSize.text   = strValue
        
        self.view.endEditing(true)
        
        
    }
    
    
    
    
    
    
    func setData(){
        
    }
   
    
    
    func setShadow(_ view: UIButton){
        
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func clickToBack(_ sender: Any) {
       
        
    }
    
    
    @IBAction func clickToPickerOpen(_ sender: Any) {
         showPicker()
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
        
        
  
            self.strValue = arrIteam?[row] as? String
        
        
        
    }
}




extension ModifieModel: UITextFieldDelegate{
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(5)
        self.pickerView.reloadAllComponents()
    }
    
    
    
}

