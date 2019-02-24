//  PPTextView.swift
//  NavigationBarSample
//  Copyright © 2019 TR. All rights reserved.

import UIKit

class FujiFilmTextView: UITextView {
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
        applyCustomisations()

        updateText()
        observeLanguageChangeNotification()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func applyCustomisations() {
        textContainer.lineFragmentPadding = 10
        // Setting it programmtically because of Interface Builder way is not working
        clipsToBounds = true
    }

    @objc private func updateText() {
        guard let key = self.textKey else { return }
        print(key)
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
