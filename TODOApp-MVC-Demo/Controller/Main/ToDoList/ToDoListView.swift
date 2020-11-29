//
//  ToDoListView.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/29/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ToDoListView: UIView {
    // MARK:- Outletss
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var noTaskLabel: UILabel!
  // MARK:- Public Method
        func setup(){
            self.setupBackGround()
            self.setupLabel()
            self.tableViewConfiguration()
            self.addBackground()
        }
    
    // to transform the cell form south
    func transformPlus(){
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            
        }
    }
    // to transform the cell form north
    func transformMince(){
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)
        }}
    // to transform the cell
    func transform(){
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    // to animate the cell
    func animate(row: Int?){
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(row!),
            options: [.curveEaseInOut],
            animations: {
                self.transform()
        })
    }


    }
    // MARK:- Private Method
    extension ToDoListView {
         private func setupBackGround(){
            self.backgroundColor = Colors.primaryColor
        }
        private func setupLabel(){
            noTaskLabel.text = LabelText.noDataFound
            noTaskLabel.textColor = Colors.primaryColor
            noTaskLabel.font.withSize(16)
        }
//        private func setupUserImages(){
//            profileImgView.layer.cornerRadius = profileImgView.frame.height / 2
//            profileImgView.contentMode = .scaleToFill
//            profileImgView.layer.borderWidth = 2.0
//            profileImgView.layer.borderColor = Colors.placholderColor.cgColor
//        }
        private func tableViewConfiguration(){
            self.taskTableView.register(UINib(nibName: Cells.taskDataTVCell, bundle: nil), forCellReuseIdentifier: Cells.taskDataTVCell)
            self.taskTableView.separatorStyle = .none
            self.taskTableView.rowHeight = UITableView.automaticDimension
            self.taskTableView.isOpaque = false
            self.noTaskLabel.isHidden = true
            self.taskTableView.reloadData()
        }
         func addBackground(){
        // Add a background view to the table view
        let backgroundImage = UIImage(named: ImagesName.backgroundImage)
        let imageView = UIImageView(image: backgroundImage)
        taskTableView.backgroundView = imageView
        }

//        private func setupImages(){
//
//            profileImgView.image = UIImage(named: ImagesName.backgroundImage)
//            profileImgView.contentMode =  .scaleToFill
//
//        }
            

    }



