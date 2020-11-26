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
        self.setUpLabel()
        self.setUpLineView()
    }
    // MARK:- Configuration Of Cell
    private func setUpLineView(){
   //     lineView.frame.width = CGSize(width: width, height: 3)
        lineView.backgroundColor = Colors.labelColor
    }

    private func setUpLabel(){
        createdAtLabel.textColor = Colors.labelColor
        createdAtLabel.font = UIFont(name:"Helvetica Neue",size:14)
        descriptionLabel.textColor = Colors.primaryColor
        descriptionLabel.font = UIFont(name:"Helvetica Neue",size:14)
        descriptionLabel.backgroundColor = .clear
    }

    private func setUpImage(){
        taskImg.layer.cornerRadius = taskImg.frame.height / 2
        taskImg.contentMode = .scaleToFill
        taskImg.image = UIImage(named: ImagesName.toDoIcon)
    }
    func setupCellTaskData(object: TaskData)
    {   descriptionLabel.text = "\(object.description ) "
        let date = object.createdAt
        createdAtLabel.text = "\(date)" //"30/10/2020"
        
    }    
}
