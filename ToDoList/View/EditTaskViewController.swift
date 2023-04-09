//
//  EditTaskViewController.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import UIKit

class EditTaskViewController: UIViewController {

    var editedTask : Tasks = Tasks()
    var coreDataViewModel : CoreDataViewModel?

    @IBOutlet weak var editTaskName: UITextField!
    @IBOutlet weak var editTaskDescriptions: UITextField!
    @IBOutlet weak var taskPriority: UISegmentedControl!
    @IBOutlet weak var taskState: UISegmentedControl!
    @IBOutlet weak var taskDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataViewModel = CoreDataViewModel()
        editTaskName.text = editedTask.title
        editTaskDescriptions.text = editedTask.descriptions
    }
    override func viewWillAppear(_ animated: Bool) {
        taskPriority.selectedSegmentIndex = (editedTask.priority ?? 0) - 1
        taskState.selectedSegmentIndex = (editedTask.state ?? 0) - 1
        taskDate.date = editedTask.date ?? Date()
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func editTaskPriority(_ sender: Any) {
        switch taskPriority.selectedSegmentIndex
        {
            case 0 :
                editedTask.priority = 1
            case 1 :
                editedTask.priority = 2
            case 2 :
                editedTask.priority = 3
            default :
                editedTask.priority = 1
        }
    }
    @IBAction func editTaskState(_ sender: Any) {
        switch taskState.selectedSegmentIndex
        {
            case 0 :
                editedTask.state = 1
            case 1 :
                editedTask.state = 2
            case 2 :
                editedTask.state = 3
            default :
                editedTask.state = 1
        }
    }
    @IBAction func editTaskDate(_ sender: Any) {
        editedTask.date = taskDate.date
    }
    @IBAction func saveEditedTask(_ sender: Any) {
        let editAlert : UIAlertController  = UIAlertController(title:"Edit this task?", message:"Are you sure you want to edit this task ?", preferredStyle: .actionSheet)
            editAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ [self] action in
                editedTask.title = editTaskName.text
                editedTask.descriptions = editTaskDescriptions.text
                coreDataViewModel?.tasksDataBase.editTask(editedTask: self.editedTask)
                navigationController?.popViewController(animated: true)
            }))
            editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(editAlert, animated:true, completion:nil )
        
    }
    
}
