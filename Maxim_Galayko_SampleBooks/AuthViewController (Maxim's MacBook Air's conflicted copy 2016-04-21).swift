//
//  ViewController.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/20/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class AuthViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var authButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDependencies()
        performSegueWithIdentifier("testSegue", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        performSegueWithIdentifier("testSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func updateDependencies() {
        authButton.delegate = self
    }

    
    // MARK: - FBSDKLoginButtonDelegate
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("authorized")
        
        performSegueWithIdentifier("testSegue", sender: self)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("logout")
    }
}

