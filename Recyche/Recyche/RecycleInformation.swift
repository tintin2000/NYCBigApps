//
//  RecycleInformation.swift
//  Recyche
//
//  Created by Zel Marko on 08/10/15.
//  Copyright © 2015 Giving Tree. All rights reserved.
//

import UIKit
import CoreLocation

var info_placemark: CLPlacemark!
let city = info_placemark?.locality


let recycleCodeUnknown = ["paper": "Please Check Local Recycling Rules to Determine if this type of material is recyclable","paper book cover": "Please Check Local Recycling Rules to Determine if this type of material is recyclable.", "newsprint": "Please Check Local Recycling Rules to Determine if this type of material is recyclable.", "cardboard": "Please Check Local Recycling Rules to Determine if this type of material is recyclable.", "glass": "Please Check Local Recycling Rules to Determine if this type of material is recyclable", "plastic": "Please Check Local Recycling Rules to Determine if this type of material is recyclable.", "carton": "Please Check Local Recycling Rules to Determine if this type of material is recyclable", "metal": "Please Check Local Recycling Rules to Determine if this type of material is recyclable"]
let recycleCodesInfo = ["paper": "Put paper in your recycling bag or bin.\r\r  Recycle according to \(city!) recycling instructions in properly colored and labeled receptacles.","paper book cover": "Put newspapers, magazines & catalogs with other paper. \r Recycle according to \(city!) recycling instructions in properly colored and labeled receptacles.", "newsprint": "Put newspapers, magazines & catalogs with other paper. \r Recycle according to \(city!) recycling instructions in properly colored and labeled receptacles.", "cardboard": "Flatten and tie large corrugated boxes, or break them into small pieces. \r\r  Recycle according to \(city!) recycling instructions in properly colored and labeled receptacles.", "glass": "Rinse and place with your glass, metal and plastic recyclables.\r\r  Recycle according to \(city!) recycling instructions in properly colored and labeled receptacles.", "plastic": "Rinse and place with your glass, metal and plastic recyclables. \r  Recycle according to \(city!) recycling instructions in properly colored and labeled receptacles.", "carton": "Rinse and place with your glass, metal and plastic recyclables.", "metal": "Rinse and place with your glass, metal and plastic recyclables. \r\r  Recycle according to \(city!) recycling instructions in properly colored and labeled receptacles.","plastic6": "This plastic type is not accepted for Recycling.\r  Please dispose according to  \(city!) waste instructions."]

let recycleCodes = ["SELECT PRODUCT MATERIAL", "PETE 1", "HDPE 2", "PVC 3", "LDPE 4", "PP 5", "PS 6", "SHELF-STABLE CARTON", "REFRIGERATED CARTON", "GLASS GREEN", "GLASS CLEAR", "GLASS BROWN", "PAPER", "CARDBOARD", "NEWSPRINT", "PAPER BACK BOOK", "ALUMINUM", "TIN OR STEEL", "PAINT OR AEROESOL CANS"]

func materialForCode(code: String) -> String {
    
    switch code {
        
    case "PETE 1", "HDPE 2", "PVC 3", "LDPE 4", "PP 5", "PS 6":
        return "PLASTIC"
    case "SHELF-STABLE CARTON", "REFRIGERATED CARTON":
        return "CARTON"
    case  "GLASS GREEN", "GLASS CLEAR", "GLASS BROWN":
        return "GLASS"
    case  "PAPER", "PAPER BACK BOOK", "NEWSPRINT":
        return "PAPER"
    case  "CARDBOARD":
        return "CARDBOARD"
    case  "ALUMINUM", "TIN OR STEEL", "PAINT OR AEROESOL CANS":
        return "METAL"
    default:
        return "OTHER"
    }
    
}



func colorForCode(code: String) -> UIColor {
    switch code {
    case "PETE 1", "HDPE 2", "PVC 3", "LDPE 4", "PP 5", "PS 6", "PLASTIC":
        return colorWithHexString("88D5EC")
    case  "SHELF-STABLE CARTON", "REFRIGERATED CARTON", "CARTON":
        return colorWithHexString("7EA0D2")
    case  "GLASS GREEN", "GLASS CLEAR", "GLASS BROWN", "GLASS":
        return colorWithHexString("CFDE4E")
    case  "PAPER", "PAPER BACK BOOK", "NEWSPRINT":
        return colorWithHexString("D8914F")
    case  "CARDBOARD":
        return colorWithHexString("D8914F")
    case  "ALUMINUM", "TIN OR STEEL", "PAINT OR AEROESOL CANS", "METAL":
        return colorWithHexString("E486B7")
    default:
        return colorWithHexString("F3F7DE")
    }
}

func instructionForCode(code: String) -> String {
    
  
    
    
    switch code {
    case  "PETE 1", "HDPE 2", "PVC 3", "LDPE 4", "PP 5", "PS 6":
        return recycleCodesInfo["plastic"]!
    case  "SHELF-STABLE CARTON", "REFRIGERATED CARTON":
        return recycleCodesInfo["carton"]!
    case  "GLASS GREEN", "GLASS CLEAR", "GLASS BROWN":
        return recycleCodesInfo["glass"]!
    case  "PAPER", "PAPER BACK BOOK", "NEWSPRINT":
        return recycleCodesInfo["paper"]!
    case  "CARDBOARD":
        return recycleCodesInfo["cardboard"]!
    case  "ALUMINUM", "TIN OR STEEL", "PAINT OR AEROESOL CANS":
        return recycleCodesInfo["metal"]!
    default:
        return "nothing"
    }
}

func instructionForCode6(code: String) -> String {
    switch code {
    case  "PETE 1", "HDPE 2", "PVC 3", "LDPE 4", "PP 5":
        return recycleCodesInfo["plastic"]!
    case  "PS 6":
        return recycleCodesInfo["plastic6"]!
    case  "SHELF-STABLE CARTON", "REFRIGERATED CARTON":
        return recycleCodesInfo["carton"]!
    case  "GLASS GREEN", "GLASS CLEAR", "GLASS BROWN":
        return recycleCodesInfo["glass"]!
    case  "PAPER", "PAPER BACK BOOK", "NEWSPRINT":
        return recycleCodesInfo["paper"]!
    case  "CARDBOARD":
        return recycleCodesInfo["cardboard"]!
    case  "ALUMINUM", "TIN OR STEEL", "PAINT OR AEROESOL CANS":
        return recycleCodesInfo["metal"]!
    default:
        return "nothing"
    }
}




func instructionForCodeUknown(code: String) -> String {
    switch code {
    case  "PETE 1", "HDPE 2", "PVC 3", "LDPE 4", "PP 5", "PS 6":
        return recycleCodeUnknown["plastic"]!
    case  "SHELF-STABLE CARTON", "REFRIGERATED CARTON":
        return recycleCodeUnknown["carton"]!
    case  "GLASS GREEN", "GLASS CLEAR", "GLASS BROWN":
        return recycleCodeUnknown["glass"]!
    case  "PAPER", "PAPER BACK BOOK", "NEWSPRINT":
        return recycleCodeUnknown["paper"]!
    case  "CARDBOARD":
        return recycleCodeUnknown["cardboard"]!
    case  "ALUMINUM", "TIN OR STEEL", "PAINT OR AEROESOL CANS":
        return recycleCodeUnknown["metal"]!
    default:
        return "nothing"
    }
}

func colorWithHexString (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substringFromIndex(1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.grayColor()
    }
    
    let rString = (cString as NSString).substringToIndex(2)
    let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
    let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner(string: rString).scanHexInt(&r)
    NSScanner(string: gString).scanHexInt(&g)
    NSScanner(string: bString).scanHexInt(&b)
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}

func verifyUrl (urlString: String?) -> Bool {
    //Check for nil
    if let urlString = urlString {
        // create NSURL instance
        if let url = NSURL(string: urlString) {
            // check if your application can open the NSURL instance
            return UIApplication.sharedApplication().canOpenURL(url)
        }
    }
    return false
}

