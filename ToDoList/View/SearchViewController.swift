//
//  SearchViewController.swift
//  ToDoList
//
//  Created by Fatma on 08/04/2023.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {

    var tempAllTasksList : [NSManagedObject] = []
    var searchedTasksList : [NSManagedObject] = []
    var coreDataViewModel : CoreDataViewModel?
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var searchedTasksTableView: UITableView!
    {
        
            didSet{
                searchedTasksTableView.dataSource = self
                searchedTasksTableView.delegate = self
                let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
                searchedTasksTableView.register(nib, forCellReuseIdentifier: "taskCell")
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataViewModel = CoreDataViewModel()
        tempAllTasksList = coreDataViewModel?.tasksDataBase.fetchTasks(state: 1) ?? []
        tempAllTasksList.append(contentsOf: coreDataViewModel?.tasksDataBase.fetchTasks(state: 2) ?? [])
        tempAllTasksList.append(contentsOf: coreDataViewModel?.tasksDataBase.fetchTasks(state: 3) ?? [])
        //search.placeholder = "Search"
        //definesPresentationContext = true
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedTasksList.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.taskTitle.text = searchedTasksList[indexPath.row].value(forKey: "title") as? String
        switch searchedTasksList[indexPath.row].value(forKey: "priority") as? Int
        {
        case 1 :
            cell.taskPriorityImage.image = UIImage(named: "high")
        case 2 :
            cell.taskPriorityImage.image = UIImage(named: "med")
        case 3 :
            cell.taskPriorityImage.image = UIImage(named: "low")
        default :
            cell.taskPriorityImage.image = UIImage(named: "high")
        }
        return cell
    }
}

extension SearchViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editTaskVC = storyboard?.instantiateViewController(withIdentifier: "editTask") as! EditTaskViewController
        editTaskVC.editedTask.id = searchedTasksList[indexPath.row].value(forKey: "id") as? UUID
        editTaskVC.editedTask.title = searchedTasksList[indexPath.row].value(forKey: "title") as? String
        editTaskVC.editedTask.descriptions = searchedTasksList[indexPath.row].value(forKey: "descriptions") as? String
        editTaskVC.editedTask.date = searchedTasksList[indexPath.row].value(forKey: "date") as? Date
        editTaskVC.editedTask.priority = searchedTasksList[indexPath.row].value(forKey: "priority") as? Int
        editTaskVC.editedTask.state = searchedTasksList[indexPath.row].value(forKey: "state") as? Int
        navigationController?.pushViewController(editTaskVC, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product from cart ?", preferredStyle: .actionSheet)
            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ [self] action in
                self.coreDataViewModel?.tasksDataBase.deleteTask(id: searchedTasksList[indexPath.row].value(forKey: "id") as! UUID,taskState: 1)
                self.searchedTasksList.remove(at: indexPath.row)
                self.searchedTasksTableView.reloadData()
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(deleteAlert, animated:true, completion:nil )
    }
}

extension SearchViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "")
        {
            searchedTasksList = []
            searchedTasksTableView.reloadData()
        }
        else
        {
            searchedTasksList = []
            for i in tempAllTasksList
            {
                if (i.value(forKey: "title") as! String).uppercased().contains(searchText.uppercased())
                {
                    searchedTasksList.append(i)
                }
            }
            searchedTasksTableView.reloadData()
            //  searchedTasksList = tempAllTasksList.filter({ ($0 .value(forKey: "title")! as AnyObject).uppercased().contains(searchText.uppercased())
        }
}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
}

