//
//	QuestionDataSecond.swift

//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class QuestionDataSecond : NSObject, NSCoding{

	var questionId : Int!
	var questionText : String!
	var value : [String]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		questionId = json["questionId"].intValue
		questionText = json["questionText"].stringValue
		value = [String]()
		let valueArray = json["value"].arrayValue
		for valueJson in valueArray{
			value.append(valueJson.stringValue)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if questionId != nil{
			dictionary["questionId"] = questionId
		}
		if questionText != nil{
			dictionary["questionText"] = questionText
		}
		if value != nil{
			dictionary["value"] = value
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         questionId = aDecoder.decodeObject(forKey: "questionId") as? Int
         questionText = aDecoder.decodeObject(forKey: "questionText") as? String
         value = aDecoder.decodeObject(forKey: "value") as? [String]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if questionId != nil{
			aCoder.encode(questionId, forKey: "questionId")
		}
		if questionText != nil{
			aCoder.encode(questionText, forKey: "questionText")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}
