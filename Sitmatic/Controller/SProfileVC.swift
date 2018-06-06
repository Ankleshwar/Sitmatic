//
//  SProfileVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 06/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class SProfileVC: UIViewController {
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnLogOut.layer.cornerRadius = 5.0;
          self.viewProfile.layer.cornerRadius = 5.0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    


}
