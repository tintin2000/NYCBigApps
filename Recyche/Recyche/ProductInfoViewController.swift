//
//  ProductInfoViewController.swift
//  Recyche
//
//  Created by Zel Marko on 20/09/15.
//  Copyright © 2015 Giving Tree. All rights reserved.
//

import UIKit
import Alamofire
import CloudKit
import CoreData
import CoreLocation


let URLString = "http://www.searchupc.com/handlers/upcsearch.ashx?request_type=3"
let access_token = "C6D5DA80-A126-4235-A35A-26E73FC64C2F"
let UPC_code =  "037000088806"
let UPC = "0892685001003"

class ProductInfoViewController: UIViewController  {
    
    var scannedProduct: CKRecord!
    var placemark:  CLPlacemark!
    
     let cityToFind = ["Atlanta","Los Angeles", "San Francisco", "New York" ,"San Antonio", "San Diego", "San Jose", "Austin" , "Jacksonville","Columbus","Fort Worth","Charlotte","El Paso","Denver", "Memphis", "Boston", "Nashville", "Oklahoma City", "Portland" ,"Louisville" ,"Albuquerque", "Tucson", "Sacramento" , "Long Beach" , "Kansas City", "Mesa","Minneapolis","Oakland","Miami","Colorado Springs","Omaha","Tulsa", "Cleveland","Wichita", "New Orleans", "Arlington","Bakersfield", "Tampa","Anaheim" ]
     let cityToFind6 = ["Chicago", "Houston", "Philadelphia", "Phoenix", "Dallas", "Indianapolis", " Washington DC", "Orlando"]
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productNameDetail: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var materialDetailLabel: UILabel!
    @IBOutlet weak var recycleInstructionsTextView: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
        for code in recycleCodes {
            if code == scannedProduct.valueForKey("material") as! String {
    
                if let city = placemark.locality {
                    if cityToFind.contains(city)
                    {
                      recycleInstructionsTextView.text! = instructionForCode(code)
                    } else if cityToFind6.contains(city){
                       recycleInstructionsTextView.text! = instructionForCode6(code)
                    }
                    else {
                      recycleInstructionsTextView.text! = instructionForCodeUknown(code)
                    }

                    
                }
                
            }
        }
        
        if let name = scannedProduct.valueForKey("name") as? String {
            productNameLabel.text = name
            productNameDetail.hidden = true
        }
        else {
            productNameLabel.text = "No product name available for this product."
            productNameDetail.text = "Check the recycling instructions below."
        }
        
        if let mat = scannedProduct.valueForKey("material") as? String {
            materialLabel.text = materialForCode(mat)
            materialDetailLabel.text = mat
        }
        
        if scannedProduct.valueForKey("image") != nil {
            let imageAsset = scannedProduct.valueForKey("image") as! CKAsset
            productImageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path!)
        }
        else {
            let code = scannedProduct.valueForKey("material") as! String
            productImageView.image = UIImage(named: code)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        addToPersonalDatabase(scannedProduct)
       
    }
    
    @IBAction func toScanner(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resour  ces that can be recreated.
    }
    
    func addToPersonalDatabase(product: CKRecord!) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        Product.createInManagedObjectContext(managedObjectContext, _name: product.valueForKey("name") as! String, _material: product.valueForKey("material") as! String, _date: NSDate())
        
        do {
            try managedObjectContext.save()
        }
        catch _ {
            // Error
        }
    }
    
   

}

