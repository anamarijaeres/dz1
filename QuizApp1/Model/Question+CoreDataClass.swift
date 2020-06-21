//
//  Question+CoreDataClass.swift
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
//@objc(Question)
//public class Question: NSManagedObject {
//        class func getEntityName() -> String {
//            return "Question"
//        }
//    
//        class func firstOrCreate(withTitle title: String) -> Question? {
//            let context = DataController.shared.persistentContainer.viewContext
//    
//            let request: NSFetchRequest<Question> = Question.fetchRequest()
//            request.predicate = NSPredicate(format: "title = %@", title)
//            request.returnsObjectsAsFaults = false
//    
//            do {
//                let questions = try context.fetch(request)
//                if let question = questions.first {
//                    return question
//                } else {
//                    let newQuestion = Question(context: context)
//                    return newQuestion
//                }
//            } catch {
//                return nil
//            }
//        }
//    
//        class func createFrom(json: [String: Any]) -> Question? {
//        print("parsing")
//                 if let questions=json as? [String:Any],
//                        let question=questions["question"] as? String,
//                        let answers=questions["answers"] as? [String],
//                        let correctAnswer=questions["correct_answer"] as? Int{
//                     if let question = Question.firstOrCreate(withTitle: question) {
//                        question.question=question
//                        question.answers=answers
//                        question.correctAnswer=correctAnswer ?? -1
//                     do {
//                         let context = DataController.shared.persistentContainer.viewContext
//                         try context.save()
//                         return question
//                     } catch {
//                         print("Failed saving")
//                     }
//                    }else{
//                        question.answers=nil
//                        question.correctAnswer=nil
//                        question.question=nil
//                     }
//                   
//            }
//         return nil
//        }
//
//}
