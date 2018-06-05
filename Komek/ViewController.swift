//
//  ViewController.swift
//  Komek
//
//  Created by Бексултан on 16.04.2018.
//  Copyright © 2018 Бексултан. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var signinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = 8
        signinButton.layer.cornerRadius = 8
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

