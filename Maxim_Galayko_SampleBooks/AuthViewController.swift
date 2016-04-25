//
//  ViewController.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class AuthViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var authButton: FBSDKLoginButton!
    @IBOutlet var genresButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDependencies()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func updateDependencies() {
        authButton.delegate = self
        genresButton.hidden = FBSDKAccessToken.currentAccessToken() == nil
    }

    
    // MARK: - FBSDKLoginButtonDelegate
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        genresButton.hidden = result.token == nil
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        genresButton.hidden = true
        BestSellersSavingService().removeAll()
    }
}

