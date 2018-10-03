//
//	HomeData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class HomeData : NSObject, NSCoding{

	var image : String!
	var name : String!
	var video : String!
    var banner : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		image = json["image"].stringValue
		name = json["name"].stringValue
		video = json["video"].stringValue
        banner = json["banner"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if image != nil{
			dictionary["image"] = image
		}
		if name != nil{
			dictionary["name"] = name
		}
		if video != nil{
			dictionary["video"] = video
		}
        if banner != nil{
            dictionary["banner"] = video
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         image = aDecoder.decodeObject(forKey: "image") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         video = aDecoder.decodeObject(forKey: "video") as? String
        banner = aDecoder.decodeObject(forKey: "banner") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if video != nil{
			aCoder.encode(video, forKey: "video")
		}
        if banner != nil{
            aCoder.encode(video, forKey: "banner")
        }

	}

}
