//
//  SHomeVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class SHomeVC: UIViewController {

    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollViewForSlider: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var strNamePrivate: String = "private"
    public var strNamePublic: String = "public"
    fileprivate var strNameFileprivate: String = "fileprivate"
    open var strNameOpen: String = "open"
    static var strNameStatic : String = "static"
    
    var arrImages = ["Chair1.jpg","Chair2.jpg","chair3.jpg","chair7.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.collectionView.register(UINib(nibName: "HomeCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor.clear
        self.strNamePrivate = "NewPrivate"
        self.strNameFileprivate = "Newfileprivate"
       
        print(SHomeVC.strNameStatic)
         SHomeVC.strNameStatic = "strStatic"
         print(SHomeVC.strNameStatic)
      
    }
    
    func setValue(strPrivate: String, strFilePrivate: String, strStatic: String) {
        self.strNamePrivate = strPrivate
        self.strNameFileprivate = strFilePrivate
        SHomeVC.strNameStatic = strStatic
          print(SHomeVC.strNameStatic)
          print(self.strNamePrivate)
          print(self.strNameFileprivate)
    }
    
    
    open func setValueOpen(strValue:String){
        
        self.strNameOpen = strValue
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        setImageSlider()
    }
    
    @IBAction func clickToProfile(_ sender: Any) {
        
        let vc = SProfileVC(nibName: "SProfileVC", bundle: nil)
  
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setImageSlider(){
        
        let scrollViewWidth:CGFloat = self.scrollViewForSlider.frame.width
        let scrollViewHeight:CGFloat = self.scrollViewForSlider.frame.height
        
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "slider1.png")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "slider2.jpg")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "slider3.jpg")

        
        self.scrollViewForSlider.addSubview(imgOne)
        self.scrollViewForSlider.addSubview(imgTwo)
        self.scrollViewForSlider.addSubview(imgThree)
         self.scrollViewForSlider.contentInset = UIEdgeInsets.zero
        self.scrollViewForSlider.contentSize = CGSize.init(width:self.scrollViewForSlider.frame.width * 3 + 10, height:self.scrollViewForSlider.frame.height)
        self.scrollViewForSlider.delegate = self
        self.pageController.currentPage = 0
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    @objc func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollViewForSlider.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.scrollViewForSlider.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollViewForSlider.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollViewForSlider.frame.height), animated: true)
    }
    
    @IBAction func clickToStartOrder(_ sender: Any) {
        let vc = OrderProccessing(nibName: "OrderProccessing", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    

    
    
    

}

extension SHomeVC: UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
 
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
    
        self.pageController.currentPage = Int(currentPage);
      
     
    }
}
extension SHomeVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCell
        var strName = ""
        if indexPath.section == 0{
             strName = arrImages[indexPath.row]
        }
        else{
            if indexPath.row == 0{
                strName = arrImages[2]
            }
            else{
                strName = arrImages[3]
            }
        }
        
        cell.imgProducte.image = UIImage(named: strName)
  
     
        
        return cell
    }
    
    
}
extension SHomeVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2 - 10, height: collectionViewWidth/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
