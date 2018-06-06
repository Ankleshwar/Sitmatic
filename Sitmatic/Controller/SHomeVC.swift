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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//        let imgFour = UIImageView(frame: CGRect(x:scrollViewWidth*3, y:0,width:scrollViewWidth, height:scrollViewHeight))
//        imgFour.image = UIImage(named: "Slide 4")
        
        self.scrollViewForSlider.addSubview(imgOne)
        self.scrollViewForSlider.addSubview(imgTwo)
        self.scrollViewForSlider.addSubview(imgThree)
        //self.scrollViewForSlider.addSubview(imgFour)
        //4
        self.scrollViewForSlider.contentSize = CGSize(width:self.scrollViewForSlider.frame.width * 3, height:self.scrollViewForSlider.frame.height)
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

}

extension SHomeVC: UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageController.currentPage = Int(currentPage);
        // Change the text accordingly
     
    }
}

