//
//  ViewController.swift
//  PracticeWithBiomethricAuth
//
//  Created by Cahyanto Setya Budi on 02/05/20.
//  Copyright © 2020 Cahyanto Setya Budi. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authTouchID()
    }

    func authTouchID() {
        let localAuth = LAContext()
        localAuth.localizedFallbackTitle = "Please use your passcode"

        var authError: NSError?
        let reason = "Authentication required to access the secure data"
        
        if localAuth.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            localAuth.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, evaluateError) in
                if success {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Success", message: "Authenticated succesfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    //Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                }
            }
        } else {
            guard let error = authError else {
                return
            }
            print(error)
        }
    }

}

