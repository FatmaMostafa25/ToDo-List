//
//  SignUpViewController.swift
//  ToDoList
//
//  Created by Fatma on 07/04/2023.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TasksTabBar") as! TasksTabBarController
        navigationController?.pushViewController(tabBarVC, animated: true)
    }
    @IBAction func signIn(_ sender: Any) {
        let signInVC = storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        navigationController?.pushViewController(signInVC, animated: true)

    }

}
