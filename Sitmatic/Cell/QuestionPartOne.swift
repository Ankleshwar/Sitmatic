//
//  QuestionPartOne.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

protocol QuestionPartOneDelegate {
   func didTapbtnYes(_ sender: UIButton)
    func didTapbtnNo(_ sender: UIButton)
}



class QuestionPartOne: UICollectionViewCell {
    
    var delegate:QuestionPartOneDelegate?
    
    
    @IBOutlet weak var lblAnswerOne: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblAnswerTwo: UILabel!
    
    
    @IBOutlet weak var btnNo: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func clickToBtnYes(_ sender: Any) {
        btnYes.tag = 100
        delegate?.didTapbtnYes(sender as! UIButton)
    }
    

    @IBAction func clickToBtnNo(_ sender: Any) {
        btnNo.tag = 200
         delegate?.didTapbtnNo(sender as! UIButton)
    }
    
    
    

}
