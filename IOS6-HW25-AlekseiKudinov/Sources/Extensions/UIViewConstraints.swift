//
//  UIViewConstraints.swift
//  IOS6-HW25-AlekseiKudinov
//
//  Created by Алексей Кудинов on 15.08.2022.
//

import UIKit

public extension UIView {

    func addConstraints(
        centerX: NSLayoutXAxisAnchor? = nil, centerXPadding: CGFloat = 0,
        centerY: NSLayoutYAxisAnchor? = nil, centerYPadding: CGFloat = 0,
        top: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = 0,
        left: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0,
        right: NSLayoutXAxisAnchor? = nil, paddingRight: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil, paddingBottom: CGFloat = 0,
        width: CGFloat = 0, height: CGFloat = 0
    ) {
        translatesAutoresizingMaskIntoConstraints = false

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: centerXPadding).isActive = true
        }

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: centerYPadding).isActive = true
        }

        // Use the top parameter to set the top constarint
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        // Use the left parameter to set the left constarint
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        // Use the bottom parameter to set the bottom constarint
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        // Use the right parameter to set the right constarint
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        // Use the width parameter to set the top constarint
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        // Use the height parameter to set the top constarint
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


