//
//  LoginViewController.swift
//  Recyche
//
//  Created by Zel Marko on 20/09/15.
//  Copyright © 2015 Giving Tree. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil {
            loginButton.hidden = true
            self.performSegueWithIdentifier("unwindLoginSegue", sender: self)
        }
        else {
            // Error
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // Logged in
    }
    
    
    // MARK: - Navigation
    
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "unwindLoginSegue" {
//            let scannerViewController = segue.destinationViewController as! ScannerViewController
//            scannerViewController.appStart = true
//        }
//     Get the new view controller using segue.destinationViewController.
//     Pass the selected object to the new view controller.
//    }
    
    
}

