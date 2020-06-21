//
//  SingleQuizViewController.swift
//  QuizApp1
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class SingleQuizViewController: UIViewController {
    
    @IBAction func leaderBoardButtonTapped(_ sender: UIButton) {
    
        let leaderboardViewController = LeaderBoardViewController()

        navigationController?.pushViewController(leaderboardViewController, animated: true)
        
    }
    @IBOutlet weak var leaderboardButon: UIButton!
    @IBOutlet weak var questionViewContainer: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var questionScrollView: UIScrollView!
    var dispatchGroup=DispatchGroup()
    var quiz: QuizStruct?
    var counter:Int=0
    var noOfRightAnswers:Int=0;
    var questionCounter:Int=0
    var start:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionScrollView.isHidden=true
        titleLabel.text = quizTitle
        image.kf.setImage(with: imageUrl)
    }
    @IBAction func startButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.start=Date()
            self.questionScrollView.isHidden=false
            for question in self.quiz!.allquestions{
            
                let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 350*self.questionCounter+10, y: 10), size: CGSize(width: 300, height: 700)), question: (self.quiz?.allquestions[self.questionCounter])!)
                questionView.delegate=self
               
                self.questionScrollView.addSubview(questionView)
                self.questionCounter+=1
               // print(self.questionCounter)
                
            }
            print("jj")
             

            
        }
        
    }
    
    var quizTitle: String {
        return quiz?.title!.uppercased() ?? ""
    }
    

    var imageUrl: URL? {
        if let urlString = quiz?.image {
            return URL(string: urlString)
        }
        return nil
    }
    
//    func addQuestionView(_ number:Int){
//        dispatchGroup.enter()
//        var brojac=0
//        while(true){
//        for question in quiz!.allquestions{
//            let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 300, height: 700)), question: self.quiz!.allquestions[brojac])
//            questionView.delegate=self
//            questionView.isHidden=true
//           questionScrollView.insertSubview(questionView, at: brojac)
//            brojac+=1
//            }
//            self.dispatchGroup.leave()
//            break
//        }
//
//    }
//    func showQuestion(_ number:Int){
//
//        let views=questionScrollView.subviews
//        for view in views{
//            view.isHidden=true;
//        }
//        views[number].isHidden=false
//
//
//    }
    func quizFinished(){
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        let elapseTimeInSeconds = Date().timeIntervalSince(start as! Date)
        print(elapseTimeInSeconds)
        let defaults=UserDefaults.standard
        let parameters = ["quiz_id": quiz?.id,
                          "user_id": defaults.string(forKey: "token")] as [String : Any]

        //create the url with URL
        let urlString="​https://iosquiz.herokuapp.com/api/result";        guard let url=URL(string:urlString) else {
            print("Adresa nije dobra.")
            return  } //change the url

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
            request.addValue(defaults.string(forKey: "token")!, forHTTPHeaderField: "Authorization")

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
                          defaults.set(json["user_id"], forKey: "user_id")
                          defaults.set(json["token"], forKey: "token")
                          DispatchQueue.main.async {
                          let vc = ListOfQuizzesViewController(nibName: "ListOfQuizzesViewController", bundle: nil)
                          self.present(vc, animated: true)
                          }
                      }
                  } catch let error {
                      print("Error occured")
                  }
              })
              task.resume()
        
    }

  

}
extension SingleQuizViewController: QuestionViewDelegate {
    func nextQuestion(_ correct: Bool) {
        
        if correct{noOfRightAnswers=noOfRightAnswers+1
            //print(noOfRightAnswers)
        }
        let bounds=questionScrollView.bounds
     
        counter+=1
        print(counter)
        print(quiz?.allquestions.count)
        if counter==(quiz?.allquestions.count)! {quizFinished()}
        let point = questionScrollView.contentOffset
        questionScrollView.setContentOffset(CGPoint (x: point.x+350,y: 10), animated: true)
            
        }
    }


