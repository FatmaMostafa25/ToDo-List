//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import UIKit

class AddTaskViewController: UIViewController {

    var addedTask : Tasks = Tasks()
    var coreDataViewModel : CoreDataViewModel?
    @IBOutlet weak var addTaskName: UITextField!
    @IBOutlet weak var addTaskDescriptions: UITextField!
    @IBOutlet weak var taskPriority: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataViewModel = CoreDataViewModel()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addTaskPriority(_ sender: Any) {
        switch taskPriority.selectedSegmentIndex
        {
            case 0 :
                addedTask.priority = 1
            case 1 :
                addedTask.priority = 2
            case 2 :
                addedTask.priority = 3
            default :
                addedTask.priority = 1
        }
    }
    
    @IBAction func saveTask(_ sender: Any) {
        let addAlert : UIAlertController  = UIAlertController(title:"Add this task?", message:"Are you sure you want to add this task to your ToDoList?", preferredStyle: .actionSheet)
        addAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ [self] action in
            addedTask.title = addTaskName.text
            addedTask.descriptions = addTaskDescriptions.text
            addedTask.state = 1
            coreDataViewModel?.tasksDataBase.saveTask(newTask: addedTask)
            navigationController?.popViewController(animated: true)
        }))
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addAlert, animated:true, completion:nil )
    }
}
