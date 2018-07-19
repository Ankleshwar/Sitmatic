//
//  UIWindowExtensions.swift
//  VoyMate
//
//  Created by Opiant on 03/04/18.
//  Copyright © 2018 Opiant. All rights reserved.
//

import Foundation
import UIKit

public extension UIWindow {
    
    /// Transition Options
    public struct TransitionOptions {
        
        /// Curve of animation
        ///
        /// - linear: linear
        /// - easeIn: ease in
        /// - easeOut: ease out
        /// - easeInOut: ease in - ease out
        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                let key: String!
                switch self {
                case .linear:        key = kCAMediaTimingFunctionLinear
                case .easeIn:        key = kCAMediaTimingFunctionEaseIn
                case .easeOut:        key = kCAMediaTimingFunctionEaseOut
                case .easeInOut:    key = kCAMediaTimingFunctionEaseInEaseOut
                }
                return CAMediaTimingFunction(name: key)
            }
        }
        
        /// Direction of the animation
        ///
        /// - fade: fade to new controller
        /// - toTop: slide from bottom to top
        /// - toBottom: slide from top to bottom
        /// - toLeft: pop to left
        /// - toRight: push to right
        public enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            
            /// Return the associated transition
            ///
            /// - Returns: transition
            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = kCATransitionPush
                switch self {
                case .fade:
                    transition.type = kCATransitionFade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = kCATransitionFromLeft
                case .toRight:
                    transition.subtype = kCATransitionFromRight
                case .toTop:
                    transition.subtype = kCATransitionFromTop
                case .toBottom:
                    transition.subtype = kCATransitionFromBottom
                }
                return transition
            }
        }
        
        /// Background of the transition
        ///
        /// - solidColor: solid color
        /// - customView: custom view
        public enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        
        /// Duration of the animation (default is 0.20s)
        public var duration: TimeInterval = 0.20
        
        /// Direction of the transition (default is `toRight`)
        public var direction: TransitionOptions.Direction = .toRight
        
        /// Style of the transition (default is `linear`)
        public var style: TransitionOptions.Curve = .linear
        
        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background? = nil
        
        /// Initialize a new options object with given direction and curve
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        
        public init() { }
        
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }
    
    
    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    public func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        
        var transitionWnd: UIWindow? = nil
        if let background = options.background {
            transitionWnd = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWnd?.rootViewController = UIViewController.newController(withView: view, frame: transitionWnd!.bounds)
            case .solidColor(let color):
                transitionWnd?.backgroundColor = color
            }
            transitionWnd?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        self.makeKeyAndVisible()
        
        if let wnd = transitionWnd {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.duration), execute: {
                wnd.removeFromSuperview()
            })
        }
    }
}

internal extension UIViewController {
    
    /// Create a new empty controller instance with given view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - frame: frame
    /// - Returns: instance
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
    
}



class Car{
    var color = "Red"
    static let singletonCar = Car()
}

/*//
 //  OrderProccessing.swift
 //  Sitmatic
 //
 //  Created by Opiant tech Solutions Pvt. Ltd. on 07/06/18.
 //  Copyright © 2018 Ankleshwar. All rights reserved.
 //
 
 import UIKit
 import Toast_Swift
 
 
 class OrderProccessing: BaseViewController , StartOrderdDelegate {
 
 
 
 @IBOutlet weak var tostView: UIView!
 @IBOutlet weak var tostLable: UILabel!
 
 
 var isback = false
 
 @IBOutlet weak var tableView: UITableView!
 var arrQuestion: Array<Dictionary<String,Any>>?
 var arrAnswer: [[String: String]]  = Array()
 var arrCurrent: [[String: String]]  = Array()
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
 var dicAnsData = Dictionary<String, String>()
 // var serverArray: [[String: String]]  = Array()
 var serverArray: [[String: String]]  = Array()
 
 var  value: Int = 0
 
 @IBOutlet weak var lblQuestionValueCount: UILabel!
 
 @IBOutlet weak var lblQuestion: UILabel!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
 setInitial()
 
 }
 
 
 
 
 func setInitial(){
 self.lblYes.text = arrQuestion?[0]["option1"] as? String
 self.lblNo.text = arrQuestion?[0]["option2"] as? String
 //self.lblQuestion.text  = arrQuestion?[0]["queText"] as? String
 
 _ = arrQuestion?[value]["queId"] as! String
 let quename = arrQuestion?[value]["queText"] as! String
 //self.lblQuestion.text  = strID + " " + quename
 self.lblQuestion.text  =   quename
 
 self.btnYes.setButtonImage("off.png")
 self.btnNo.setButtonImage("off.png")
 self.isYesbtnTap = false
 self.arrayPersnonID.append("1")
 self.arrayPersnonID.append("2")
 
 self.btnprevious.isHidden = true
 }
 
 
 
 
 
 @IBAction func clickToCancel(_ sender: Any) {
 
 
 
 _ = SweetAlert().showAlert("Confirm Cancellation", subTitle: "Are you sure you want to cancel this order?", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.darkBlue , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
 if isOtherButton == true {
 
 
 }
 else {
 
 self.navigationController?.popViewController(animated: true)
 }
 }
 
 }
 
 
 func setDataOnBack(isBack: Bool) {
 self.isback = isBack
 self.btnNext.isEnabled = true
 }
 
 
 
 @IBAction func clickToNext(_ sender: Any) {
 
 
 if self.isYesbtnTap == false  {
 self.showToast(message: "Please select a valid option")
 self.btnYes.setButtonImage("red.png")
 self.btnNo.setButtonImage("red.png")
 
 }else if isback == true {
 
 goToNext()
 isback = false
 
 }
 else{
 
 
 let strID = (arrQuestion?[value]["queId"] as? String)!
 
 dicData  = arrCurrent[value]
 
 if strID == dicData["queId"]{
 self.setNextDataOnBack(dicLocaldata: dicData)
 }else{
 self.setNextButtonData(strId: (arrQuestion?[value]["queId"] as? String)!)
 }
 
 
 
 
 
 
 }
 
 
 }
 
 
 
 fileprivate func setNextDataOnBack(dicLocaldata : [String : String]) {
 
 
 
 self.lblYes.text = dicLocaldata["option1"]
 self.lblNo.text = dicLocaldata["option2"]
 //let strID = dicLocaldata["queId"]
 let quename = dicLocaldata["queText"]
 self.lblQuestion.text = quename
 let  strSelected = dicLocaldata["selected"]
 
 if strSelected == "Yes"{
 self.btnYes.setButtonImage("on.png")
 self.btnNo.setButtonImage("off.png")
 
 }else {
 self.btnYes.setButtonImage("off.png")
 self.btnNo.setButtonImage("on.png")
 }
 }
 
 
 
 
 func setNextButtonData(strId:String){
 
 
 if strSelected == "No" {
 
 dataForNo(strId)
 
 
 }else{
 dataForYes(strId)
 }
 
 }
 
 //MARK: set Data No Button
 
 
 
 @IBAction func clickToBtnNo(_ sender: Any) {
 //  self.btnNext.isEnabled = false
 self.btnYes.setButtonImage("off.png")
 self.btnNo.setButtonImage("on.png")
 self.isYesbtnTap = true
 self.isPreviousClick = false
 self.strSelected = "No"
 let strId = arrQuestion?[value]["queId"] as? String
 dataForNo(strId!)
 
 
 
 
 }
 
 
 
 
 fileprivate func dataForNo(_ strId: String) {
 if strId == "3"{
 serverSideData()
 
 goToNext()
 }
 else if strId == "5Y"{
 serverSideData()
 
 
 goToNext()
 }
 else{
 
 if strId == "2" || strId == "3Y" || strId == "4Y"{
 if let index = self.arrayPersnonID.index(of: "3") {
 print(index)
 
 }
 
 else{
 self.arrQuestion?.append(["queId": "3","queText": "Which is your dominant eye?", "option1":"Left","option2":"Right"])
 
 self.arrayPersnonID.append("3")
 }
 
 
 }
 
 
 //nextQues()
 self.view.isUserInteractionEnabled = false
 Timer.scheduledTimer(timeInterval: 0.5,
 target: self,
 selector: #selector(nextQues),
 userInfo: nil,
 repeats: false)
 
 
 }
 }
 
 // MARK:- Set Yes Button Data
 
 
 
 @IBAction func clickToBtnYes(_ sender: Any) {
 self.btnYes.setButtonImage("on.png")
 self.btnNo.setButtonImage("off.png")
 
 self.isYesbtnTap = true
 self.strSelected = "Yes"
 let strId = arrQuestion?[value]["queId"] as? String
 
 self.isPreviousClick = false
 dataForYes(strId!)
 
 }
 
 
 
 fileprivate func dataForYes(_ strId: String) {
 if strId == "5Y"{
 serverSideData()
 
 
 
 goToNext()
 }
 
 else if strId == "3"{
 serverSideData()
 
 
 goToNext()
 }
 else{
 
 
 
 
 if strId == "2" {
 
 if let index = self.arrayPersnonID.index(of: "3Y") {
 print(index)
 }
 else{
 self.arrQuestion?.append(["queId": "3Y","queText": "Did you have corrective eye surgery?", "option1":"Yes","option2":"No"])
 self.arrayPersnonID.append("3Y")
 }
 
 
 }
 if strId == "3Y"{
 
 if let index = self.arrayPersnonID.index(of: "4Y") {
 print(index)
 }
 else{
 self.arrQuestion?.append(["queId": "4Y","queText": "Was it monovision correction? (Was one eye corrected for reading and the other corrected for distance?", "option1":"Yes","option2":"No"])
 self.arrayPersnonID.append("4Y")
 }
 
 
 }
 else if strId == "4Y"{
 
 if let index = self.arrayPersnonID.index(of: "5Y") {
 print(index)
 
 }
 else{
 self.arrQuestion?.append(["queId": "5Y","queText": "Which eye was corrected for reading?", "option1":"Left","option2":"Right"])
 
 self.arrayPersnonID.append("5Y")
 
 }
 
 }
 
 self.view.isUserInteractionEnabled = false
 
 Timer.scheduledTimer(timeInterval: 0.5,
 target: self,
 selector: #selector(nextQues),
 userInfo: nil,
 repeats: false)
 
 
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
 self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(strId!) }
 self.arrCurrent.append(dicData)
 self.btnprevious.isHidden = false
 
 
 
 serverSideData()
 
 if (self.arrQuestion?.count == value){
 ECSAlert().showAlert(message: "Que overThanku", controller: self)
 }
 else{
 
 self.value += 1
 coreNextDataSet(self.value)
 }
 }
 
 
 
 
 
 fileprivate func coreNextDataSet(_ value: Int) {
 
 self.lblYes.text = arrQuestion?[value]["option1"] as? String
 self.lblNo.text = arrQuestion?[value]["option2"] as? String
 let strID = arrQuestion?[value]["queId"] as! String
 let quename = arrQuestion?[value]["queText"] as! String
 self.lblQuestion.text  =   quename
 self.lblQuestionValueCount.text = strID + " " + "of 19 Questions"
 self.btnYes.setButtonImage("off.png")
 self.btnNo.setButtonImage("off.png")
 self.isYesbtnTap = false
 self.view.isUserInteractionEnabled = true
 
 }
 
 
 
 
 fileprivate func serverSideData() {
 let  strId = arrQuestion?[value]["queId"] as! String
 self.serverArray = self.serverArray.filter { !$0.values.contains(strId) }
 dicAnsData["id"] = arrQuestion?[value]["queId"] as? String
 dicAnsData["ans"] = strSelected
 self.serverArray.append(dicAnsData)
 dicData["selected"] = strSelected
 dicData["option1"] = arrQuestion?[value]["option1"] as? String
 dicData["option2"] = arrQuestion?[value]["option2"] as? String
 dicData["queText"] = arrQuestion?[value]["queText"] as? String
 
 dicData["queId"] = strId
 self.arrCurrent = self.arrCurrent.filter { !$0.values.contains(strId) }
 self.arrCurrent.append(dicData)
 }
 
 
 
 
 func goToNext() {
 
 self.serverArray = serverArray.compactMap { $0 }
 
 print("~~~~~~~~~~~~~~~~~\(self.value)~~~~~~~~~~~~~~~~~~~~~~~")
 
 
 
 
 let vc = StartOrderd(nibName: "StartOrderd", bundle: nil)
 
 vc.serverArraySecond = serverArray
 vc.delegate = self
 self.navigationController?.pushViewController(vc, animated: true)
 
 }
 
 
 
 
 
 
 
 
 //MARK:- Previous Set Data
 
 
 @IBAction func clickToPrivious(_ sender: Any) {
 print("main value is\(value) ")
 
 self.btnNo.isEnabled = true
 self.btnYes.isEnabled = true
 
 if (value == 0){
 self.btnprevious.isHidden = true
 
 }
 else{
 
 
 
 self.setPriviousSubData()
 
 
 
 
 }
 
 }
 
 
 fileprivate func setPriviousSubData(){
 print(arrAnswer)
 self.arrQuestion?.remove(at: value)
 self.arrayPersnonID.remove(at: value)
 value -= 1
 serverArray.remove(at: value)
 setPreviousData(valueindex: value)
 self.arrAnswer.remove(at: value)
 print(arrAnswer)
 
 self.isPreviousClick = true
 }
 
 
 
 
 
 
 
 
 
 
 func setPreviousData(valueindex : Int){
 
 
 print(valueindex)
 
 isback = false
 var dicdata  = arrAnswer[valueindex]
 
 self.lblYes.text = dicdata["option1"]
 self.lblNo.text = dicdata["option2"]
 let strID = dicdata["queId"]
 let quename = dicdata["queText"]
 
 self.lblQuestion.text  =   quename!
 self.lblQuestionValueCount.text = strID! + " " + "of 19 Questions"
 let  strSelected = dicdata["selected"]
 
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
 
 if strID == "1"{
 self.btnprevious.isHidden = true
 
 self.btnNext.isEnabled = true
 self.serverArray.removeAll()
 self.arrayPersnonID.removeAll()
 value = 0
 self.arrayPersnonID.append("1")
 self.arrayPersnonID.append("2")
 
 arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
 
 
 
 }
 
 
 
 self.isPreviousClick = true
 
 self.isYesbtnTap = true
 }
 
 
 }
 
*/







