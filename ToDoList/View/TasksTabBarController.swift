//
//  TasksTabBarController.swift
//  ToDoList
//
//  Created by Fatma on 07/04/2023.
//

import UIKit

class TasksTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
            self.tabBar.layer.masksToBounds = true
            self.tabBar.isTranslucent       = true
            self.tabBar.layer.borderWidth   = 2
            self.tabBar.layer.borderColor   = UIColor(named: "first")?.cgColor
            self.tabBar.backgroundColor = .white
            self.tabBar.layer.cornerRadius  = UIScreen.main.bounds.width / 20
            UITabBar.appearance().isTranslucent = true
       //     UITabBar.appearance().barTintColor = .white
    //        UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "first")
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
    }
    

    // MARK: - Navigation

}
