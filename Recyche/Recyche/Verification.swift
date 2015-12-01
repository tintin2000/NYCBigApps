//
//  Verification.swift
//  Recyche
//
//  Created by Zel Marko on 30/11/15.
//
//

import Foundation
import CloudKit

class Verification {
  
  func checkForExistingUpcMaterial(upc_material: String) {
    let container = CKContainer.defaultContainer()
    let publicData = container.publicCloudDatabase
    
    publicData.fetchRecordWithID(CKRecordID(recordName: upc_material)) { (record, error) -> Void in
      if error != nil {
        if error!.userInfo["ServerErrorDescription"] as! String == "Record not found" {
          let productToVerify = CKRecord(recordType: "Verification", recordID: CKRecordID(recordName: upc_material))
          if let userId = NSUserDefaults.standardUserDefaults().valueForKey("id") as? String {
            productToVerify.setValue(userId, forKey: "user1")
            publicData.saveRecord(productToVerify) { (record, error) -> Void in
              if error != nil {
                print(error?.localizedDescription)
              }
              else {
                print("Record Saved")
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
          print(user1)
        }
      }
      else {
        // Wierd Situation
      }
    }
  }
}
