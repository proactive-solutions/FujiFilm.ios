//  PPTabBarItem.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

final class FujiFilmTabBarItem: UITabBarItem {
    private var textKey: String?

    @IBInspectable var localeTextKey: String? {
        get {
            return self.textKey
        }

        set {
            self.textKey = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        observeLanguageChangeNotification()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.0) { [weak self] in
            guard let this = self else { return }
            this.updateText()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc private func updateText() {
        guard let key = self.textKey else {
            return
        }
        title = key.localised
    }

    private func observeLanguageChangeNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateText),
            name: NSNotification.Name(rawValue: GeneralConstant.languageChangeNotification),
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
