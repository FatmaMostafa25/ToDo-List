//
//  WelcomeViewController.swift
//  ToDoList
//
//  Created by Fatma on 07/04/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var appLogoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        appLogoImage.image = UIImage(named: "icon")
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func signIn(_ sender: Any) {
        let signInVC = storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction func skipAction(_ sender: Any) {
        let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TasksTabBar") as! TasksTabBarController
        
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
    // MARK: - Navigation


}
