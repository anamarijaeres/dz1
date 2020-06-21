//
//  TabBarController.swift
//  QuizApp1
//
//  Created by five on 19/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav=generateNavController(vc: ListOfQuizzesViewController(), title: "Quizzes", image: UIImage(systemName: "house")!)
        let nav1=generateNavController(vc: SearchViewController(), title: "Search", image: UIImage(systemName: "magnifyingglass")!)
        let nav2=generateNavController(vc: SettingsViewController(), title: "Settings", image: UIImage(systemName: "gear")!)
        viewControllers=[nav,nav1,nav2]
    }
    
    fileprivate func generateNavController(vc: UIViewController, title:String, image: UIImage)-> UINavigationController{
        vc.navigationItem.title=title
        let navigationController=UINavigationController(rootViewController: vc)
        navigationController.title=title
        navigationController.tabBarItem.image=image
        return navigationController
        
    }
    
}
