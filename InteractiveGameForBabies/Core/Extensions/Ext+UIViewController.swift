//
//  Ext+UIViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 19.06.2022.
//

import UIKit

extension UIViewController {

    // Height of status bar + navigation bar (if navigation bar exist)
    var barsHeight: CGFloat {
        var totalHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0

        if let navigationBar = navigationController?.navigationBar {
            for subview in navigationBar.subviews {
                totalHeight += subview.frame.height
            }
        }

        return totalHeight
    }
}
