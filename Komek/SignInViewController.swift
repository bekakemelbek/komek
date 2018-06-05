//
//  SignInViewController.swift
//  Komek
//
//  Created by Бексултан on 22.04.2018.
//  Copyright © 2018 Бексултан. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var email_field: UITextField!
    
    @IBOutlet weak var password_field: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endEdit(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email_field.text!, password: password_field.text!, completion: { (user, error) in
            if error == nil{
               // if (!(user?.isEmailVerified)!){
                    self.performSegue(withIdentifier: "mySegue", sender: self)
               //}else{
                 // self.message.textColor = UIColor.red
                   // self.message.text = "Your email is not verified!"
               //}
            }else{
                self.message.text = "Error! User is not signed up."
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
