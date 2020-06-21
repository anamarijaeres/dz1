//
//  SettingsViewController.swift
//  QuizApp1
//
//  Created by five on 19/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
   
    @IBOutlet weak var logOutButton: UIButton!
    @IBAction func logOutButtonTaped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "user_id")
      
        
        let vc = LoginViewController()
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
        self.dismiss(animated: true, completion: nil)
      
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text=UserDefaults.standard.string(forKey: "username")
        
        // Do any additional setup after loading the view.
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
