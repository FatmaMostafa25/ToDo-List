//
//  DoneViewController.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import UIKit

class DoneViewController: UIViewController {

    @IBOutlet weak var doneTasksTableView: UITableView!
    {
        didSet{
            doneTasksTableView.dataSource = self
            doneTasksTableView.delegate = self
            let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
            doneTasksTableView.register(nib, forCellReuseIdentifier: "taskCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension DoneViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.taskTitle.text = "Task Name"
        cell.taskPriorityImage.image = UIImage(named: "low")
        return cell
    }
}

extension DoneViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
