//
//  Verification.swift
//  Recyche
//
//  Created by Zel Marko on 30/11/15.
//
//

import Foundation
import CloudKit
import Alamofire
import SwiftyJSON

protocol VerificationDelegate {
  func goAhead(record: CKRecord)
}

class Verification {
  
  var delegate: VerificationDelegate?
  
  func checkForExistingUpcMaterial(upc: String, material: String) {
    let container = CKContainer.defaultContainer()
    let publicData = container.publicCloudDatabase
    
    publicData.fetchRecordWithID(CKRecordID(recordName: upc + "_" + material)) { (record, error) -> Void in
      if error != nil {
        if error!.userInfo["ServerErrorDescription"] as! String == "Record not found" {
          let productToVerify = CKRecord(recordType: "Verification", recordID: CKRecordID(recordName: upc + "_" + material))
          if let userId = NSUserDefaults.standardUserDefaults().valueForKey("id") as? String {
            productToVerify.setValue(userId, forKey: "user1")
            publicData.saveRecord(productToVerify) { (record, error) -> Void in
              if error != nil {
                print(error?.localizedDescription)
              }
              else {
                print("Record Saved")
                self.newProduct(upc, material: material, save: false)
              }
            }
          }
        }
        else {
          print(error?.localizedDescription)
        }
        
      }
      else if record != nil {
        if let record = record, user1 = record.valueForKey("user1") as? String {
          if let user2 = record.valueForKey("user2") as? String {
            if user2 != NSUserDefaults.standardUserDefaults().valueForKey("id") as! String {
              print("Verified")
              self.newProduct(upc, material: material, save: true)
            }
          } else {
            if user1 != NSUserDefaults.standardUserDefaults().valueForKey("id") as! String {
              publicData.saveRecord(record) { (record, error) -> Void in
                if error != nil {
                  print(error?.localizedDescription)
                }
                else {
                  print("Added user2")
                  self.newProduct(upc, material: material, save: false)
                }
              }
            }
          }
        }
      }
      else {
        // Wierd Situation
      }
    }
  }
  
  func newProduct(upc: String, material:String, save: Bool) {
    var name: String!
    var imageURL: String?
    Alamofire.request(.GET, URLString, parameters: ["access_token" : access_token ,"upc": upc]).responseJSON { response in
      
      if let data = response.data {
        let json = JSON(data: data)
        if let _name = json["0"]["productname"].string {
          if _name == " " {
            name = "No Name"
          }
          else {
            name = _name
          }
        }
        else {
          name = "No Name"
        }
        
        if let _imageURL = json["0"]["imageurl"].string {
          if verifyUrl(_imageURL) {
            imageURL = _imageURL
          }
        }
      }
    }
    
    let container = CKContainer.defaultContainer()
    let publicData = container.publicCloudDatabase
    
    let product = CKRecord(recordType: "Product", recordID: CKRecordID(recordName: upc))
    product.setValue(material, forKey: "material")
    if let nm = name {
      product.setValue(nm, forKey: "name")
    }
    else {
      product.setValue("Unknown", forKey: "name")
    }
    
    if let imageURL = imageURL {
      let imageData = NSData(contentsOfURL: NSURL(string: imageURL)!)
      let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
      let fileURL = documentsURL.URLByAppendingPathComponent("imageasset")
      imageData?.writeToURL(fileURL, atomically: true)
      
      let asset = CKAsset(fileURL: fileURL)
      product.setValue(asset, forKey: "image")
    }
    if save {
      publicData.saveRecord(product) { (record, error) -> Void in
        if error != nil {
          print(error?.localizedDescription)
        }
        else {
          print("Saved Product")
          if let delegate = self.delegate {
            delegate.goAhead(product)
          }
        }
      }
    } else {
      print("ja")
      if let delegate = self.delegate {
        print("ja?")
        delegate.goAhead(product)
      }
    }
  }
}
