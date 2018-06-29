//
//  Section.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 29/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import Foundation
struct Section {
    var name: String!
    var items: [String]!
    var collapsed: Bool!
    var check:  Bool!
    
    init(name: String, items: [String], collapsed: Bool = true ,check: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
        self.check = check
       
    }
}



