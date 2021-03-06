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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var taskImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    // MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpImage()
        self.labelConfiguration()
        self.setUpLineView()
    }
    // MARK:- Configuration Of Cell
    private func setUpLineView(){
        lineView.backgroundColor = Colors.labelColor
    }
    private func labelConfiguration(){
        setUpLabel(createdAtLabel)
        setUpLabel(descriptionLabel)
    }
    private func setUpLabel( _ label: UILabel){
        label.textColor = Colors.labelColor
        label.font = UIFont(name:"Helvetica Neue",size:14)
        label.textColor = Colors.primaryColor
        label.backgroundColor = .clear
    }
    private func setUpImage(){
        taskImg.layer.cornerRadius = taskImg.frame.height / 2
        taskImg.contentMode = .scaleToFill
        taskImg.image = UIImage(named: ImagesName.toDoIcon)
    }
    func setupCellTaskData(object: TaskData)
    {  
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM a"
         descriptionLabel.text = "\(object.description ) "
        createdAtLabel.text = (object.createdAt)
    }    
}
