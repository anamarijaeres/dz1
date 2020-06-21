//
//  LoginViewController.swift
//  QuizApp1
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var dontSwitch:Bool=true
    let dispatchGroup = DispatchGroup()
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        animationOut()
        let parameters = ["username": usernameTextField.text,
                          "password": passwordTextField.text] as [String : Any]

        //create the url with URL
        let url = URL(string: "https://iosquiz.herokuapp.com/api/session")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                    
                   let defaults = UserDefaults.standard
                    defaults.set(self.usernameTextField.text, forKey: "username")
                    defaults.set(json["user_id"], forKey: "user_id")
                    defaults.set(json["token"], forKey: "token")
                    DispatchQueue.main.async {
                    let vc = TabBarController()
                    self.present(vc, animated: true)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    override func viewDidLoad() {
        animateEverythingIn()
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    func animateEverythingIn() {
        UIView.animate(withDuration: 0.1, animations: {
            self.usernameLabel.alpha=0
            self.passwordLabel.alpha=0
            self.loginButton.alpha=0

            self.titleLabel.alpha=0.2
            self.titleLabel.transform=CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
        }
        
        UIView.animate(withDuration: 2,delay: 0.1 ,animations: {
            self.usernameTextField.transform = CGAffineTransform(translationX: self.usernameTextField.center.x+150, y: 0)
            self.usernameTextField.alpha = 0.5
            self.usernameLabel.alpha=0
            self.passwordLabel.alpha=0
            self.loginButton.alpha=0
            self.titleLabel.alpha=0.2
            self.titleLabel.transform=CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
        }
        UIView.animate(withDuration: 2,delay:0.5, animations: {
            self.usernameLabel.alpha=0
            self.passwordLabel.alpha=0
            self.loginButton.alpha=0
           
            self.titleLabel.alpha=0.5
            self.titleLabel.transform=CGAffineTransform(scaleX: 0.5, y: 0.5)
          
           
            self.usernameTextField.alpha=1
            self.passwordTextField.transform = CGAffineTransform(translationX: self.passwordTextField.center.x+150, y: 0)
            self.passwordTextField.alpha=0.5
            
            }) { _ in
        }
          UIView.animate(withDuration: 2,delay:1, animations: {
            self.usernameLabel.alpha=0
            self.passwordLabel.alpha=0
            self.loginButton.alpha=0
            self.usernameLabel.transform=CGAffineTransform(translationX: self.usernameLabel.center.x+50, y: 0)
            self.passwordTextField.alpha=1
            self.titleLabel.alpha=1
            self.titleLabel.transform=CGAffineTransform(scaleX: 1, y: 1)
            self.loginButton.transform=CGAffineTransform(translationX: self.loginButton.center.x+160, y: 0)



        }) { _ in
        }
       UIView.animate(withDuration: 2,delay:1, animations: {
            self.usernameLabel.alpha=1
     
        }) { _ in
        }
        UIView.animate(withDuration: 2,delay:1.5, animations: {
                      self.passwordLabel.transform = CGAffineTransform(translationX: self.passwordLabel.center.x+50, y: 0)
            self.passwordLabel.alpha = 1
            self.loginButton.alpha=1
            
        }) { _ in
        }
       
    }
    func animationOut(){
        UIView.animate(withDuration: 1, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -200)
           }) { _ in
           }
           
        UIView.animate(withDuration: 1,delay: 0.3 ,animations: {
            self.usernameTextField.transform = CGAffineTransform(translationX: self.usernameTextField.center.x+150, y: -400)
            self.usernameLabel.transform=CGAffineTransform(translationX:self.usernameLabel.center.x+50, y: -400)
            
           }) { _ in
           }
        UIView.animate(withDuration: 1,delay:0.6, animations: {
            self.passwordTextField.transform = CGAffineTransform(translationX:self.passwordTextField.center.x+150, y: -400)
            self.passwordLabel.transform=CGAffineTransform(translationX: self.passwordLabel.center.x+50, y: -400)
         
               
               }) { _ in
           }
        UIView.animate(withDuration: 0.7,delay:0.9, animations: {
            self.loginButton.transform=CGAffineTransform(translationX: self.loginButton.center.x+160, y: -400)
            }) { _ in
            }
        
    }

}
