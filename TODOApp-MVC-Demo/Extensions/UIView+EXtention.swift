//
//  UIView+EXtention.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    // render the view within the view's bounds, then capture it as image
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { rendererContext in
            layer.render(in: rendererContext.cgContext)
        })
    }
}
