//  PPViewController.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

class FujiFilmViewController: UIViewController {
    private var textKey: String?

    @IBInspectable var localeTextKey: String? {
        get {
            return self.textKey
        }

        set {
            self.textKey = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        observeLanguageChangeNotification()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo_puma_v5-1"))
        updateText()

        let item = UIBarButtonItem(
            image: #imageLiteral(resourceName: "left-arrow"),
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )

        navigationItem.backBarButtonItem = item
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainNavigationItem.rightBarButtonItem = nil
    }

    @objc private func updateText() {
        guard let key = self.textKey else {
			return
		}
        mainNavigationItem.title = key.localised
        mainNavigationItem.titleView = nil
    }

    private func observeLanguageChangeNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateText),
            name: NSNotification.Name(rawValue: GeneralConstant.languageChangeNotification),
            object: nil
        )
    }

    func closeMenu() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    var mainNavigationItem: UINavigationItem {
        if let parentViewController = parent as? PPTabController {
            if let dashVC = parentViewController.parent as? DashboardVC {
                return dashVC.navigationItem
            }
        }
        return navigationItem
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
