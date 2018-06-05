//
//  SignUpViewController.swift
//  Komek
//
//  Created by Бексултан on 22.04.2018.
//  Copyright © 2018 Бексултан. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var email_field: UITextField!
    
    @IBOutlet weak var password_field: UITextField!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func endEdit(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        indicator.isHidden = false
        indicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email_field.text!, password: password_field.text!, completion: { (user, error) in
            
            self.indicator.stopAnimating()
            if error == nil{
                user?.sendEmailVerification(completion: { (error) in
                    if error == nil{
                        self.messageLabel.text = "Check your email.We sent you a verification link"
                        self.messageLabel.textColor = UIColor.green
                    }
                })
                
                //self.performSegue(withIdentifier: "signInSegue", sender: self)
            }else{
                self.messageLabel.text = "Something is wrong!"
                self.messageLabel.textColor = UIColor.red
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
