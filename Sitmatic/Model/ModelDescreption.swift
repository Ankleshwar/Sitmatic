//
//	ModelDescreption.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ModelDescreption : NSObject, NSCoding{

	var callDetected : String!
	var dataId : Int!
	var descriptionField : String!
	var status : String!
	var successData : SuccessData!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		callDetected = json["callDetected"].stringValue
		dataId = json["data_id"].intValue
		descriptionField = json["description"].stringValue
		status = json["status"].stringValue
		let successDataJson = json["successData"]
		if !successDataJson.isEmpty{
			successData = SuccessData(fromJson: successDataJson)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if callDetected != nil{
			dictionary["callDetected"] = callDetected
		}
		if dataId != nil{
			dictionary["data_id"] = dataId
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if status != nil{
			dictionary["status"] = status
		}
		if successData != nil{
			dictionary["successData"] = successData.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         callDetected = aDecoder.decodeObject(forKey: "callDetected") as? String
         dataId = aDecoder.decodeObject(forKey: "data_id") as? Int
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         successData = aDecoder.decodeObject(forKey: "successData") as? SuccessData

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if callDetected != nil{
			aCoder.encode(callDetected, forKey: "callDetected")
		}
		if dataId != nil{
			aCoder.encode(dataId, forKey: "data_id")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if successData != nil{
			aCoder.encode(successData, forKey: "successData")
		}

	}

}
