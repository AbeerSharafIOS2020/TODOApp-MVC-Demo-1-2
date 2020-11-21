////
////  AlertPresenter.swift
////  TODOApp-MVC-Demo
////
////  Created by AbeerSharaf on 11/21/20.
////  Copyright © 2020 IDEAEG. All rights reserved.
////
//
//import UIKit
//enum Outcome {
//    case accepted
//    case rejected
//}
//struct ConfirmationPresenter {
//    /// The question we want the user to confirm
//    static let question: String = ""
//    /// The title of the button to accept the confirmation
//    static let acceptTitle: String = ""
//    /// The title of the button to reject the confirmation
//    static let rejectTitle: String = ""
//    /// A closure to be run when the user taps one of the
//    /// alert's buttons. Outcome is an enum with two cases:
//    /// .accepted and .rejected.
//    static var handler: (Outcome) -> Void {
//        get {}
//    }
//    func present(in viewController: UIViewController) {
//        let alert = UIAlertController(
//            title: nil,
//            message: ConfirmationPresenter.question,
//            preferredStyle: .alert
//        )
//
//        let rejectAction = UIAlertAction(title: ConfirmationPresenter.rejectTitle, style: .cancel) { _ in
//            ConfirmationPresenter.self.handler(.rejected)
//        }
//
//        let acceptAction = UIAlertAction(title: ConfirmationPresenter.acceptTitle, style: .default) { _ in
//            ConfirmationPresenter.self.handler(.accepted)
//        }
//
//        alert.addAction(rejectAction)
//        alert.addAction(acceptAction)
//
//        viewController.present(alert, animated: true)
//    }
//}
//
////class NoteViewController: UIViewController {
////    func handleDeleteButtonTap() {
////        let presenter = ConfirmationPresenter(
////            question: "Are you sure you want to delete this note?",
////            acceptTitle: "Yes, delete it!",
////            rejectTitle: "Cancel",
////            handler: { [unowned self] outcome in
////                switch outcome {
////                case .accepted:
////                    self.noteCollection.delete(self.note)
////                case .rejected:
////                    break
////                }
////            }
////        )
////
////        presenter.present(in: self)
////    }
////}
