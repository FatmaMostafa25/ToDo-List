//
//  SignInViewController.swift
//  ToDoList
//
//  Created by Fatma on 07/04/2023.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var appLogoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        appLogoImage.image = UIImage(named: "icon")
    }
    
    @IBAction func signIn(_ sender: Any) {
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
