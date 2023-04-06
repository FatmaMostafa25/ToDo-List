//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var addTaskName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
