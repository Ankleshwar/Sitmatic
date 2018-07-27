//
//    SuccessData.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class SuccessData : NSObject, NSCoding{
    
    var armrestCap : String!
    var armrestCapValue : String!
    var armrestUpright : String!
    var armrestUprightValue : String!
    var backrestSize : String!
    var backrestSizeValue : String!
    var control : String!
    var controlValue : String!
    var elbowHeight : String!
    var elbowHeightValue : String!
    var elbowToElbowDistance : String!
    var elbowToElbowDistanceValue : String!
    var lowerLegLength : String!
    var lowerLegLengthValue : String!
    var lumbarHeight : String!
    var lumbarHeightValue : String!
    var model : [Model]!
    var proposedModel : String!
    var proposedPrice : Int!
    var theighBredth : String!
    var theighBredthValue : String!
    var upperLegLength : String!
    var upperLegLengthValue : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        armrestCap = json["armrestCap"].stringValue
        armrestCapValue = json["armrestCapValue"].stringValue
        armrestUpright = json["armrestUpright"].stringValue
        armrestUprightValue = json["armrestUprightValue"].stringValue
        backrestSize = json["backrestSize"].stringValue
        backrestSizeValue = json["backrestSizeValue"].stringValue
        control = json["control"].stringValue
        controlValue = json["controlValue"].stringValue
        elbowHeight = json["elbowHeight"].stringValue
        elbowHeightValue = json["elbowHeightValue"].stringValue
        elbowToElbowDistance = json["elbowToElbowDistance"].stringValue
        elbowToElbowDistanceValue = json["elbowToElbowDistanceValue"].stringValue
        lowerLegLength = json["lowerLegLength"].stringValue
        lowerLegLengthValue = json["lowerLegLengthValue"].stringValue
        lumbarHeight = json["lumbarHeight"].stringValue
        lumbarHeightValue = json["lumbarHeightValue"].stringValue
        model = [Model]()
        let modelArray = json["model"].arrayValue
        for modelJson in modelArray{
            let value = Model(fromJson: modelJson)
            model.append(value)
        }
        proposedModel = json["proposedModel"].stringValue
        proposedPrice = json["proposedPrice"].intValue
        theighBredth = json["theighBredth"].stringValue
        theighBredthValue = json["theighBredthValue"].stringValue
        upperLegLength = json["upperLegLength"].stringValue
        upperLegLengthValue = json["upperLegLengthValue"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if armrestCap != nil{
            dictionary["armrestCap"] = armrestCap
        }
        if armrestCapValue != nil{
            dictionary["armrestCapValue"] = armrestCapValue
        }
        if armrestUpright != nil{
            dictionary["armrestUpright"] = armrestUpright
        }
        if armrestUprightValue != nil{
            dictionary["armrestUprightValue"] = armrestUprightValue
        }
        if backrestSize != nil{
            dictionary["backrestSize"] = backrestSize
        }
        if backrestSizeValue != nil{
            dictionary["backrestSizeValue"] = backrestSizeValue
        }
        if control != nil{
            dictionary["control"] = control
        }
        if controlValue != nil{
            dictionary["controlValue"] = controlValue
        }
        if elbowHeight != nil{
            dictionary["elbowHeight"] = elbowHeight
        }
        if elbowHeightValue != nil{
            dictionary["elbowHeightValue"] = elbowHeightValue
        }
        if elbowToElbowDistance != nil{
            dictionary["elbowToElbowDistance"] = elbowToElbowDistance
        }
        if elbowToElbowDistanceValue != nil{
            dictionary["elbowToElbowDistanceValue"] = elbowToElbowDistanceValue
        }
        if lowerLegLength != nil{
            dictionary["lowerLegLength"] = lowerLegLength
        }
        if lowerLegLengthValue != nil{
            dictionary["lowerLegLengthValue"] = lowerLegLengthValue
        }
        if lumbarHeight != nil{
            dictionary["lumbarHeight"] = lumbarHeight
        }
        if lumbarHeightValue != nil{
            dictionary["lumbarHeightValue"] = lumbarHeightValue
        }
        if model != nil{
            var dictionaryElements = [[String:Any]]()
            for modelElement in model {
                dictionaryElements.append(modelElement.toDictionary())
            }
            dictionary["model"] = dictionaryElements
        }
        if proposedModel != nil{
            dictionary["proposedModel"] = proposedModel
        }
        if proposedPrice != nil{
            dictionary["proposedPrice"] = proposedPrice
        }
        if theighBredth != nil{
            dictionary["theighBredth"] = theighBredth
        }
        if theighBredthValue != nil{
            dictionary["theighBredthValue"] = theighBredthValue
        }
        if upperLegLength != nil{
            dictionary["upperLegLength"] = upperLegLength
        }
        if upperLegLengthValue != nil{
            dictionary["upperLegLengthValue"] = upperLegLengthValue
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        armrestCap = aDecoder.decodeObject(forKey: "armrestCap") as? String
        armrestCapValue = aDecoder.decodeObject(forKey: "armrestCapValue") as? String
        armrestUpright = aDecoder.decodeObject(forKey: "armrestUpright") as? String
        armrestUprightValue = aDecoder.decodeObject(forKey: "armrestUprightValue") as? String
        backrestSize = aDecoder.decodeObject(forKey: "backrestSize") as? String
        backrestSizeValue = aDecoder.decodeObject(forKey: "backrestSizeValue") as? String
        control = aDecoder.decodeObject(forKey: "control") as? String
        controlValue = aDecoder.decodeObject(forKey: "controlValue") as? String
        elbowHeight = aDecoder.decodeObject(forKey: "elbowHeight") as? String
        elbowHeightValue = aDecoder.decodeObject(forKey: "elbowHeightValue") as? String
        elbowToElbowDistance = aDecoder.decodeObject(forKey: "elbowToElbowDistance") as? String
        elbowToElbowDistanceValue = aDecoder.decodeObject(forKey: "elbowToElbowDistanceValue") as? String
        lowerLegLength = aDecoder.decodeObject(forKey: "lowerLegLength") as? String
        lowerLegLengthValue = aDecoder.decodeObject(forKey: "lowerLegLengthValue") as? String
        lumbarHeight = aDecoder.decodeObject(forKey: "lumbarHeight") as? String
        lumbarHeightValue = aDecoder.decodeObject(forKey: "lumbarHeightValue") as? String
        model = aDecoder.decodeObject(forKey: "model") as? [Model]
        proposedModel = aDecoder.decodeObject(forKey: "proposedModel") as? String
        proposedPrice = aDecoder.decodeObject(forKey: "proposedPrice") as? Int
        theighBredth = aDecoder.decodeObject(forKey: "theighBredth") as? String
        theighBredthValue = aDecoder.decodeObject(forKey: "theighBredthValue") as? String
        upperLegLength = aDecoder.decodeObject(forKey: "upperLegLength") as? String
        upperLegLengthValue = aDecoder.decodeObject(forKey: "upperLegLengthValue") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if armrestCap != nil{
            aCoder.encode(armrestCap, forKey: "armrestCap")
        }
        if armrestCapValue != nil{
            aCoder.encode(armrestCapValue, forKey: "armrestCapValue")
        }
        if armrestUpright != nil{
            aCoder.encode(armrestUpright, forKey: "armrestUpright")
        }
        if armrestUprightValue != nil{
            aCoder.encode(armrestUprightValue, forKey: "armrestUprightValue")
        }
        if backrestSize != nil{
            aCoder.encode(backrestSize, forKey: "backrestSize")
        }
        if backrestSizeValue != nil{
            aCoder.encode(backrestSizeValue, forKey: "backrestSizeValue")
        }
        if control != nil{
            aCoder.encode(control, forKey: "control")
        }
        if controlValue != nil{
            aCoder.encode(controlValue, forKey: "controlValue")
        }
        if elbowHeight != nil{
            aCoder.encode(elbowHeight, forKey: "elbowHeight")
        }
        if elbowHeightValue != nil{
            aCoder.encode(elbowHeightValue, forKey: "elbowHeightValue")
        }
        if elbowToElbowDistance != nil{
            aCoder.encode(elbowToElbowDistance, forKey: "elbowToElbowDistance")
        }
        if elbowToElbowDistanceValue != nil{
            aCoder.encode(elbowToElbowDistanceValue, forKey: "elbowToElbowDistanceValue")
        }
        if lowerLegLength != nil{
            aCoder.encode(lowerLegLength, forKey: "lowerLegLength")
        }
        if lowerLegLengthValue != nil{
            aCoder.encode(lowerLegLengthValue, forKey: "lowerLegLengthValue")
        }
        if lumbarHeight != nil{
            aCoder.encode(lumbarHeight, forKey: "lumbarHeight")
        }
        if lumbarHeightValue != nil{
            aCoder.encode(lumbarHeightValue, forKey: "lumbarHeightValue")
        }
        if model != nil{
            aCoder.encode(model, forKey: "model")
        }
        if proposedModel != nil{
            aCoder.encode(proposedModel, forKey: "proposedModel")
        }
        if proposedPrice != nil{
            aCoder.encode(proposedPrice, forKey: "proposedPrice")
        }
        if theighBredth != nil{
            aCoder.encode(theighBredth, forKey: "theighBredth")
        }
        if theighBredthValue != nil{
            aCoder.encode(theighBredthValue, forKey: "theighBredthValue")
        }
        if upperLegLength != nil{
            aCoder.encode(upperLegLength, forKey: "upperLegLength")
        }
        if upperLegLengthValue != nil{
            aCoder.encode(upperLegLengthValue, forKey: "upperLegLengthValue")
        }
        
    }
    
}
