//
//  LoginViewController.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        if usernameField.text != "" && passwordField.text != "" {
            APIManager.shared.login(username: usernameField.text!, password: passwordField.text!, onSuccess: { (success) in
                APIManager.shared.getCurrentUser(onSuccess: { (user) in
                    APIManager.shared.user = user
                }, onFailure: { (error) in
                    print(error)
                })
            }) { (error) in
                print(error)
            }
        }
    }
    
}
