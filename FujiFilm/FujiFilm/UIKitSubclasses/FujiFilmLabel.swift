//  PPLabel.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

final class FujiFilmLabel: UILabel {
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
        updateText()
        observeLanguageChangeNotification()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc private func updateText() {
        guard let key = self.textKey else { return }
        text = key.localised
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
