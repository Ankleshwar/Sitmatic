//
//  AddressVC.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 10/07/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class AddressVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Question 1
          pattern(value: 5)
        //Question 2
        let value =  getDistance(array: [1, 5, 3, 7, 2, 8, 3, 4, 5, 9, 9, 3, 1, 3, 2, 9], num1: 2, num2: 9)
        print(value)
      // Question 3
        print("ankleshwar".reverseVowels())
   
    }

    
    

    
    func getDistance(array:Array<Any>,num1: Int,num2: Int) -> Int{
  
        if array.count <= 0{
            return -1
        }
        var numPos1 = array.count
        var numPos2 = array.count
        var  numDist = array.count
        
        for i in 0..<array.count{
            
            if array[i] as! Int == num1{
                numPos1 = i
            }else if array[i] as! Int == num2{
                numPos2 = i
            }

            if numPos1 < array.count && numPos2 < array.count {
                if numDist > abs(numPos1 - numPos2) {
                    numDist = abs(numPos1 - numPos2)
                    

                }
            }
        }
       
        
        return  numDist == array.count ? -1  : numDist
    }

    
    
    func pattern(value: Int)
    {
        
        for j in 1...value
        {
            
            for i in 1...j
            {
                if i > 2{
                    break
                    }
                print(j)
               
            }
             //print("\n")
        }
        for j in (1..<value).reversed()
        {
            
            for i in 1...j
            {
                if i > 2{
                    break
                }
                print(j)
                
            }
            //print("\n")
        }
        
    }
}

extension String{
    static let vowels: Set<Character> = ["a","e","i","o","u","A","E","I","O","U"]
    func reverseVowels() -> String{
        if self == ""{
            return ""
        }
        var chars = Array(self.characters)
        let indices = chars.enumerated().filter{ String.vowels.contains($0.1)}.map{$0.0}
        let count = indices.count
        for i in 0..<count {
            chars.swapAt(indices[i], indices[count-i-1])
        }
        return String(chars)
    }
    
    
}
