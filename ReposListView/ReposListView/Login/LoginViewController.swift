//
//  LoginViewController.swift
//  ReposListView
//
//  Created by Alexandru Dinu on 25/06/2019.
//  Copyright © 2019 noname. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        // Regular login attempt. Add the code to handle the login by email and password.
        guard let email = usernameTextField.text, let pass = passwordTextField.text else {
            // It should never get here
            return
        }

        AppRequests.init().basicAuthentication(username: email, password: pass) { [weak self] response in
            // Handle Error
            guard let _ = response else {
                let message = "Login faild"
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            self?.performSegue(withIdentifier: "next", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
