//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskPriorityImage: UIImageView!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
