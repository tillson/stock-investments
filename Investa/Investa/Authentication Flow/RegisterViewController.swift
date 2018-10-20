//
//  RegisterViewController.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        if usernameField.text != "" && passwordField.text != "" {
            APIManager.shared.register(username: usernameField.text!, password: passwordField.text!, onSuccess: { (user) in
                //
            }) { (error) in
                print(error)
            }
        }
    }
    
}
