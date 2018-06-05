//
//  ProfileViewController.swift
//  Komek
//
//  Created by Бексултан on 23.04.2018.
//  Copyright © 2018 Бексултан. All rights reserved.
//
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import MapKit

class ProfileViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    static var longitude1 = 1.1
    static var latitude1 = 1.1
    static var isVisible = false
    private var dbRef: DatabaseReference?
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var name_field: UITextField!
    
    @IBOutlet weak var surname_field: UITextField!
    
    @IBOutlet weak var telnumber_field: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var age_field: UITextField!
    var job = ""
    
    @IBAction func endEdit(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    let jobs = ["Doctor", "IT Spec", "Plumber","Teacher"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.layer.cornerRadius = 3
        locationLabel.isHidden = !ProfileViewController.isVisible
        dbRef = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return jobs[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jobs.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        job = jobs[row]
    }
    
    @IBAction func finishPressed(_ sender: UIButton) {
        do{
        if(name_field.text != "" && surname_field.text != "" &&
            telnumber_field.text != "" && age_field.text != "" && ProfileViewController.longitude1 != 1.1 && ProfileViewController.latitude1 != 1.1){
            
            let currentUser = Auth.auth().currentUser;
            let post = [
                "name": name_field.text!,
                "surname": surname_field.text!,
                "telnumber": telnumber_field.text!,
                "age": age_field.text!,
                "job": job,
                "longitude": String(ProfileViewController.longitude1),
                "latitude": String(ProfileViewController.latitude1)
            ]
           /* dbRef?.childByAutoId().setValue(["name": name_field.text!])
            dbRef?.childByAutoId().setValue(["surname": surname_field.text!])
            dbRef?.childByAutoId().setValue(["telnumber": telnumber_field.text!])
            dbRef?.childByAutoId().setValue(["age": age_field.text!])
            dbRef?.childByAutoId().setValue([job])
            dbRef?.childByAutoId().setValue(["longitude": String(ProfileViewController.longitude1)])*/
            dbRef?.childByAutoId().setValue(post)
            performSegue(withIdentifier: "profiletoFind", sender: self)
        }else {
            messageLabel.text = "Please fill all the fields and choose location"
            print(ProfileViewController.longitude1)
            }
        }catch{
            print("fuck")
        }
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
