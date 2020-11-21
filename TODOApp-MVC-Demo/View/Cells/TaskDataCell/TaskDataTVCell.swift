//
//  TaskDataTVCell.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TaskDataTVCell: UITableViewCell {
    // MARK:- Outlets
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var taskImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK:- Configuration Of Cell
    func setupCellTaskData(object: TaskData)
    {   descriptionLabel.text = "\(object.description ) "
        let date = object.createdAt
        createdAtLabel.text = "\(date)" //"30/10/2020"
        
    }    
}
