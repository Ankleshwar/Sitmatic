//
//  SHomeVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD
import DeviceKit


class SHomeVC: BaseViewController {

    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var viewContaint: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnStarted: UIButton!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var viewLableHeight: NSLayoutConstraint!
    
  
    
    
    
    override func loadView() {
        super.loadView()
        print("loadViewCall")
    }
    //
    
    override func viewDidAppear(_ animated: Bool) {
        if let navVCsCount = self.navigationController?.viewControllers.count {
            self.navigationController?.viewControllers.removeSubrange(Range(0..<navVCsCount - 1))
        }
        
      
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.btnStarted.layer.cornerRadius = 20.0
        self.btnStarted.clipsToBounds = true
       
        let text = "Welcome to GoodFit™ by Sitmatic!\n\n"
        + "GoodFit™ guarantees a perfect fitting chair for everyone in your organization and a workstationpersonalized for them and the way they work.\n\n"
                     + "We got your back!"
        
        
        lblDescription.numberOfLines = 0
        lblDescription.text = text
        
        self.setTopView(self.viewTop, on: self, andTitle: "GoodFit™ by Sitmatic", withButton: true, withButtonTitle: "", withButtonImage: "user-icon26x26.png", withoutBackButton: true)

    }
    
  
    
 
    
    
    
    
    
    override func viewDidLayoutSubviews() {
         UIView().setShadow(self.viewContaint)
        if device.diagonal == 4  {
            self.viewLableHeight.constant = 100.0
            self.lblDescription.font = UIFont.init(name: "Roboto-Light", size: 12.0)
        }else {
            self.viewLableHeight.constant = 180.0
            self.lblDescription.font = UIFont.init(name: "Roboto-Light", size: 16.0)
        }
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
    
       
        
    }
    
    
    @objc func rightButtonClicked(_ sender: Any) {
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func clickToProfile(_ sender: Any) {
        
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
  
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func setImageSlider(){
//
//        let scrollViewWidth:CGFloat = self.scrollViewForSlider.frame.width
//        let scrollViewHeight:CGFloat = self.scrollViewForSlider.frame.height
//
//        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
//        imgOne.image = UIImage(named: "slider1.png")
//        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
//        imgTwo.image = UIImage(named: "slider2.jpg")
//        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
//        imgThree.image = UIImage(named: "slider3.jpg")
//
//
//        self.scrollViewForSlider.addSubview(imgOne)
//        self.scrollViewForSlider.addSubview(imgTwo)
//        self.scrollViewForSlider.addSubview(imgThree)
//         self.scrollViewForSlider.contentInset = UIEdgeInsets.zero
//        self.scrollViewForSlider.contentSize = CGSize.init(width:self.scrollViewForSlider.frame.width * 3 + 10, height:self.scrollViewForSlider.frame.height)
//        self.scrollViewForSlider.delegate = self
//        self.pageController.currentPage = 0
//
//        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
//    }

//    @objc func moveToNextPage (){
//
//        let pageWidth:CGFloat = self.scrollViewForSlider.frame.width
//        let maxWidth:CGFloat = pageWidth * 3
//        let contentOffset:CGFloat = self.scrollViewForSlider.contentOffset.x
//
//        var slideToX = contentOffset + pageWidth
//
//        if  contentOffset + pageWidth == maxWidth
//        {
//            slideToX = 0
//        }
//        self.scrollViewForSlider.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollViewForSlider.frame.height), animated: true)
//    }
    
    @IBAction func clickToStartOrder(_ sender: Any) {
        let vc = BasicInfoVC(nibName: "BasicInfoVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    

    
    
    

}

//extension SHomeVC: UIScrollViewDelegate{
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
//
//        let pageWidth:CGFloat = scrollView.frame.width
//        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
//
//        self.pageController.currentPage = Int(currentPage);
//
//
//    }
//}
//extension SHomeVC: UICollectionViewDelegate,UICollectionViewDataSource{
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCell
//        var strName = ""
//        if indexPath.section == 0{
//             strName = arrImages[indexPath.row]
//        }
//        else{
//            if indexPath.row == 0{
//                strName = arrImages[2]
//            }
//            else{
//                strName = arrImages[3]
//            }
//        }
//
//        cell.imgProducte.image = UIImage(named: strName)
//
//
//
//        return cell
//    }
//
//
//}
//extension SHomeVC : UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewWidth = collectionView.bounds.width
//        return CGSize(width: collectionViewWidth/2 - 10, height: collectionViewWidth/2)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
//}
