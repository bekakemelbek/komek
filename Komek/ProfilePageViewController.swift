//
//  ProfilePageViewController.swift
//  Komek
//
//  Created by Бексултан on 25.04.2018.
//  Copyright © 2018 Бексултан. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfilePageViewController: UIViewController {
     var ref: DatabaseReference!

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var telNumber: UILabel!
    @IBOutlet weak var surname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
         ref.observe(.childAdded, with: { (snapshot) in
         let userDict = snapshot.value as! [String: Any]
         let name1 = userDict["name"] as! String
         let tel1 = userDict["telnumber"] as! String
         let age1 = userDict["age"] as! String
         let job1 = userDict["job"] as! String
         let surname1 = userDict["surname"] as! String
         self.job.text = job1
         self.telNumber.text = tel1
         self.surname.text = surname1
         self.age.text = age1
         self.name.text =  name1
                    
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
