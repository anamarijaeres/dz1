//
//  LeaderBoardViewController.swift
//  QuizApp1
//
//  Created by five on 19/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {

    @IBOutlet weak var leaderTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var dispatchGroup=DispatchGroup()
 
       
    let cellReuseIdentifier2 = "cellReuseIdentifier2"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData()
        
    }
    func setupTableView(){
           leaderTableView.backgroundColor = UIColor.lightGray
                 leaderTableView.delegate = self
                 leaderTableView.dataSource = self
                 leaderTableView.separatorStyle = .none
                 
                 refreshControl = UIRefreshControl()
                 refreshControl.addTarget(self, action: #selector(ListOfQuizzesViewController.refresh), for: UIControl.Event.valueChanged)
                 leaderTableView.refreshControl = refreshControl

                 leaderTableView.register(UINib(nibName: "LeaderTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier2)
                 
                 
           
       }
    func setupData() {
        httpRequest()
         dispatchGroup.notify(queue: .main){
             print("ZADNJE")
             self.refresh()
         }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
         self.leaderTableView.reloadData()
         self.refreshControl.endRefreshing()
        }
    }
//    func fetchLeaders(){
//
//        print("token"+UserDefaults.standard.string(forKey: "token")!)
//        let urlString="​https://iosquiz.herokuapp.com/api/score?quiz_id=6"
//        let leaderService=LeaderService()
//
//        print("calling fetch leaders")
//
//        leaderService.fetchLeader(urlString: urlString){(leaders) in
//
//                   if let leaders=leaders{
//                   print("fetching quiz")
//                   DispatchQueue.main.async {
//                      // self.allQuizzes=[]
//                       //guard let quiz=quiz else {return}
////                       for quiz in quizzes{
////                           print("Ovo je naslov: \(quiz.title)")
////                           self.allQuizzes.append(quiz)
////                       }
////                       DispatchQueue.main.async{
////                           self.addQuizView()
////                           self.showPicture()
////                           self.addQuestionView()
////                           self.numOfNbaQuestions()
////
//                       //}
//                   }
//                   }else{
//                    print("bla")
////                       DispatchQueue.main.sync {
////                           self.errorLabel.isHidden=false
////                       }
//                   }
//
//               }
//
//    }
    private func httpRequest() {
        
        //create the url with NSURL
        guard let url = URL(string:"​https://iosquiz.herokuapp.com/api/score?quiz_id=4") else {
            print("Url is incorrect.")
            return  } //change the url
        let parameters = ["quiz_id":4] as [String : Any]
       
        //create the session object
        let session = URLSession.shared
        let defaults=UserDefaults.standard
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as GET
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(defaults.string(forKey: "token")!, forHTTPHeaderField: "Authorization")

        //create dataTask using the session object to send data to the server
        dispatchGroup.enter()
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
                    self.dispatchGroup.leave()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }


}

extension LeaderBoardViewController: UITableViewDataSource, UITableViewDelegate {

     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 150
     }
   
  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier2 , for: indexPath) as! LeaderTableViewCell
        cell.numberLabel.text="1."
        cell.nameLabel.text="Hrvoje"
        cell.scoreLabel.text="80.4 s"
         return cell
     }
 

 }
