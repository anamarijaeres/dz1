//
//  Quiz+CoreDataClass.swift
//  QuizApp1
//
//  Created by five on 20/06/2020.
//  Copyright © 2020 five. All rights reserved.
//
//
//
//import Foundation
//import CoreData
//
//@objc(Quiz)
//public class Quiz: NSManagedObject {
//       
//        class func getEntityName() -> String {
//            return "Quiz"
//        }
//    
//        class func firstOrCreate(withTitle title: String) -> Quiz? {
//            let context = DataController.shared.persistentContainer.viewContext
//    
//            let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
//            request.predicate = NSPredicate(format: "title = %@", title)
//            request.returnsObjectsAsFaults = false
//    
//            do {
//                let quizzes = try context.fetch(request)
//                if let quiz = quizzes.first {
//                    return quiz
//                } else {
//                    let newQuiz = Quiz(context: context)
//                    return newQuiz
//                }
//            } catch {
//                return nil
//            }
//        }
//    
//        class func createFrom(json: [String: Any]) -> Quiz? {
//        print("parsing")
//               if let jsonDict=json as? [String:Any],
//                   let title=jsonDict["title"] as? String,
//                   let level=jsonDict["level"] as? Int,
//                   let description=jsonDict["description"] as? String,
//                   let image=jsonDict["image"] as? String,
//                   let category=jsonDict["category"] as? String,
//                   let id=jsonDict["id"] as? Int,
//                   let questions=jsonDict["questions"] as? [[String:Any]]{
//                    if let quiz = Quiz.firstOrCreate(withTitle: title) {
//                        for q in questions{
//                            let q=Question.createFrom(json: q)
//                            print("Ovo su questioni:\(q!.correctAnswer)  "+"\(q!.answers)"+"\(q!.question)")
//                            quiz.allquestions?.insert(q!, at: 1)
//                      }
//                        quiz.id=Int32(id)
//                          quiz.title=title
//                          quiz.image=image
//                          quiz.category=category
//                          quiz.description=description
//                        quiz.level=Int32(level)
//                          switch category{
//                              case "SPORTS":
//                                  quiz.c=Category.SPORTS
//                              case "SCIENCE":
//                                  quiz.c=Category.SCIENCE
//                              default:
//                                  return
//                          }
//                    do {
//                        let context = DataController.shared.persistentContainer.viewContext
//                        try context.save()
//                        return quiz
//                    } catch {
//                        print("Failed saving")
//                    }
//    
//                  }
//               }else{
//            return nil
//            }
//
//    }
//}
