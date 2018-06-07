//
//  StartOrderd.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class StartOrderd: BaseViewController, QuestionPartOneDelegate {

    
    @IBOutlet weak var btnCancle: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblQuestion: UILabel!
    
   var arrQuestion: Array<Dictionary<String,Any>>?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         arrQuestion = setDataWithLocalJson("StartOrderd") as NSArray as? Array<Dictionary<String, Any>>
        self.collectionView.register(UINib(nibName: "QuestionPartOne", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")

    }

    override func viewWillAppear(_ animated: Bool) {
        
        
        
        setShadow(self.btnPrevious)
        self.setShadow(self.btnCancle)
        self.setShadow(self.btnNext)
    }
    
    func setShadow(_ view: UIButton){
        
        view.layer.masksToBounds = true;
        view.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func clickToNext(_ sender: Any) {
        
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
//        let indexpath =  IndexPath(item: 2, section: 0)
//        self.collectionView.reloadItems(at: [indexpath])
       
        
//        var indexPaths: [NSIndexPath] = []
//        for i in 0..<collectionView!.numberOfItems(inSection: 0) {
//            indexPaths.append(NSIndexPath(item: i, section: 0))
//        }
//        collectionView?.reloadItems(at: indexPaths as [IndexPath])
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let indexPaths = [Int](0..<numberOfItems).map{ IndexPath(row: $0, section: 0) }
        collectionView.reloadItems(at: indexPaths)
        
    }
    
    @IBAction func clickToPrevious(_ sender: Any) {
    }
    @IBAction func clickToCancle(_ sender: Any) {
    }
    
    
    func didTapbtnYes(_ sender: UIButton) {
        
        print(sender.tag)
        
    }
    
    func didTapbtnNo(_ sender: UIButton) {
        
          print(sender.tag)
     
    }
    
    
 
    

    
}


extension StartOrderd: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.arrQuestion?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuestionPartOne
       
        cell.delegate = self
        cell.lblAnswerOne.text = arrQuestion?[indexPath.row]["option1"] as? String
        cell.lblAnswerTwo.text = arrQuestion?[indexPath.row]["option2"] as? String
        self.lblQuestion.text  =  arrQuestion?[indexPath.row]["queText"] as? String

        return cell
    }
    
    
}
extension StartOrderd : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
