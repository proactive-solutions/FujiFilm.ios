//
//  PPTabController.swift
//  PumaPay
//
//  Created by rails on 04/02/19.
//  Copyright © 2019 PumaPay. All rights reserved.
//

import UIKit

final class FujiFilmTabController: UITabBarController {
    override func viewDidLoad() {
        addTopBorder()
    }

    override func awakeFromNib() {}

    func addTopBorder() {
        let view = UIView(frame: CGRect(x: 0, y: -1, width: tabBar.frame.size.width, height: 3))
        view.backgroundColor = UIColor.white
        tabBar.insertSubview(view, at: 0)
        PPTabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.font(style: .regular, size: 8)],
            for: .normal
        )
        PPTabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.font(style: .regular, size: 8)],
            for: .selected
        )
    }
}
