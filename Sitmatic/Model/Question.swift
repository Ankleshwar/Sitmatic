//
//	Question.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Question : NSObject, NSCoding{

	var options : [String]!
	var question : String!
	var select : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		options = [String]()
		let optionsArray = json["options"].arrayValue
		for optionsJson in optionsArray{
			options.append(optionsJson.stringValue)
		}
		question = json["question"].stringValue
		select = json["select"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if options != nil{
			dictionary["options"] = options
		}
		if question != nil{
			dictionary["question"] = question
		}
		if select != nil{
			dictionary["select"] = select
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         options = aDecoder.decodeObject(forKey: "options") as? [String]
         question = aDecoder.decodeObject(forKey: "question") as? String
         select = aDecoder.decodeObject(forKey: "select") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if options != nil{
			aCoder.encode(options, forKey: "options")
		}
		if question != nil{
			aCoder.encode(question, forKey: "question")
		}
		if select != nil{
			aCoder.encode(select, forKey: "select")
		}

	}

}
