//
//  ServiceClass.swift
//  IndusBus
//
//  Created by Opiant on 29/01/18.
//  Copyright © 2018 Opiant. All rights reserved.
// http://indusbus.opiant.online/api/osrtc/getavailableservices

import Foundation
import Alamofire
import SwiftyJSON

class ServiceClass: NSObject {
    
    typealias dictionaryBlock = (_ error: Error?, _ response: [String:Any]) -> Void
    typealias arrayBlock = (_ error: Error?, _ response: [Any]) -> Void
    

    
    var headers: [String: String] = [:]
    var body: String?
    var elapsedTime: TimeInterval?
    var arrIteam : Array<Any> = []
    
   
    
    var request: Alamofire.Request? {
        didSet {
            oldValue?.cancel()
            headers.removeAll()
            body = nil
            elapsedTime = nil
            
        }
    }
    
    
    
    
    
    
    
    
    public func getLoginDetails(strUrl:String,param:[String:String],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            
            
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    
    
    public func signUpDetails(strUrl:String,param:[String:String],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            
            
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    public func logoutUser(strUrl:String,param:[String:String],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
         requestGETURL(baseURL+strUrl, params: param as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            
            
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    
    public func verifieEmail(strUrl:String,param:[String:String],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            
            
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    
    
    
    
    

    
    
    public func getDataBusList(strUrl:String,prama:[String: AnyObject],completion: @escaping (arrayBlock)){
        
        print(prama)
        
        
        
        
//        requestPOSTURL(baseURL+strUrl, params: prama, headers: nil, success: {
//            (JSONResponse) -> Void in
//
//            print(JSONResponse)
//
//            print(JSONResponse.dictionaryObject!)
//            self.arrIteam.removeAll()
////            if "SUCCESS" == JSONResponse["wsResponse"]["message"]{
////                for rootdic in JSONResponse["service"].array!{
////
////                        let object = IBService(fromJson: rootdic)
////                        self.arrIteam.append(object)
////
////
////
////
////                }
//                completion(nil, self.arrIteam)
//        }
//            else{
//                let errorTemp = NSError(domain:"No Service Avilable", code:205, userInfo:nil)
//                completion(errorTemp,[])
//            }
//
//
//
//
//
//
//
//        }){
//            (error) -> Void in
//
//            completion(error,[])
//
//        }
//
        
        
        
        
    }
    
    public func getNearByPlace(prama:[String: AnyObject],completion: @escaping (arrayBlock)){
        
                //print(prama)
        
       let lat = prama["lat"] as! Double
       let lng = prama["lng"] as! Double
       let type = prama["type"] as! String
       let commanUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lng)&radius=5000&type=\(type)&key=AIzaSyBfK9hv6qIpL7vLV-WRa1qkiNzD4ix1Hjc"
        
        requestGETURL(commanUrl, params: [:], headers: nil, success: {
                    (JSONResponse) -> Void in
        
                   // print(JSONResponse)
        
                    print(JSONResponse.dictionaryObject!)
                    self.arrIteam.removeAll()
                    if "OK" == JSONResponse["status"]{
                        for rootdic in JSONResponse["results"].array!{
        
                              
        
//                            let object = VMGooglePlaceData(fromJson: rootdic)
//                            self.arrIteam.append(object)
        
        
                        }
                        completion(nil, self.arrIteam)
                }
                    else{
                        let errorTemp = NSError(domain:"No Service Avilable", code:205, userInfo:nil)
                        completion(errorTemp,[])
                    }
        
        
        
        
        
        
        
                }){
                    (error) -> Void in
    
                    completion(error,[])
    
                }
    
        
        
        
        
    }
    


    
    private  func requestGETURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    private func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
}
