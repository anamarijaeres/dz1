//
//  Quiz.swift
//  QuizApp1
//
//  Created by five on 10/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class Quiz{
    let title: String
    let image:String?
    let category:String
    var allquestions: [Question]=[]
    var c: Category?
 
    init?(json:Any){
        print("parsing")
        if let jsonDict=json as? [String:Any],
            let title=jsonDict["title"] as? String,
            let image=jsonDict["image"] as? String,
            let category=jsonDict["category"] as? String,
            let questions=jsonDict["questions"] as? [[String:Any]]{
            for q in questions{
                let q=Question(json: q)
                print("Ovo su questioni:\(q.correctAnswer)  "+"\(q.answers)"+"\(q.question)")
                self.allquestions.append(q)
            }
                self.title=title
                self.image=image
                self.category=category
                switch category{
                    case "SPORTS":
                        self.c=Category.SPORTS
                    case "SCIENCE":
                        self.c=Category.SCIENCE
                    default:
                        return
                }
                print("\(self.title)  "+"\(self.image)"+"\(self.category)")
        
        }else{
            return nil
        }
    }
    
}
