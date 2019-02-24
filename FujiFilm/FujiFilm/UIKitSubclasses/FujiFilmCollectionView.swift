//  PPCollectionView.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

class FujiFilmCollectionView: UICollectionView {
    override func awakeFromNib() {
        super.awakeFromNib()
        observeLanguageChangeNotification()
    }

    private func observeLanguageChangeNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadData),
            name: NSNotification.Name(rawValue: GeneralConstant.languageChangeNotification),
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
