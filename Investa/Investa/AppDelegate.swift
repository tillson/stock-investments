//
//  AppDelegate.swift
//  Investa
//
//  Created by Nicholas Grana on 10/19/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID
            let idToken = user.authentication.idToken 
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Portfolio")
            if let presented = self.window?.rootViewController?.presentedViewController {
                presented.dismiss(animated: false, completion: {
                    self.window?.rootViewController?.present(viewController, animated: false, completion: nil)
                })
            } else {
                window?.rootViewController?.present(viewController, animated: false, completion: nil)
            }
            
            
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // google sign in stuff
        GIDSignIn.sharedInstance().clientID = "1022808015987-jih90fgd9gjs6isaouqv77gvha5910h7.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }


}

