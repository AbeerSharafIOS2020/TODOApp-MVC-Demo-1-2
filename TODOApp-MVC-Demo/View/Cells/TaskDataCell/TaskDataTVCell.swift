//
//  TaskDataTVCell.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TaskDataTVCell: UITableViewCell {
    // MARK:- Outlite
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var taskImg: UIImageView!
    @IBOutlet weak var taskDataLabel: UILabel!
    
    // MARK:- Properties
    static let identifier = "TaskDataTVCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK:- Configuration Of Cell
    func setupCellTaskData(object: TaskData)
        {   taskDataLabel.text = "\(object.description ) "
            let date = object.createdAt
            createdAtLabel.text = "\(date)" //"30/10/2020"
            
            
        }

}
