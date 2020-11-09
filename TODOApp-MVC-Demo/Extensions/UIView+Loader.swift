//
//  UIView+Loader.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/4/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIView {
    
    struct LoadingProgress {
        static let  loading : NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 70, height: 70), type: .ballRotateChase, color: UIColor.blue , padding: 2)
    }
    func processOnStart() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    func processOnStop() {
        self.isUserInteractionEnabled = true
        LoadingProgress.loading.stopAnimating()
    }

    // Start Loader
    func setupActivityIndicator() -> NVActivityIndicatorView {
        LoadingProgress.loading.tag = 333
        LoadingProgress.loading.center = self.center
        self.addSubview(LoadingProgress.loading)
        return LoadingProgress.loading

    }

}
