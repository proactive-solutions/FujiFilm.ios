//  PPShadowView.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

final class FujiFilmShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) { [weak self] in
            guard let this = self else { return }
            this.addShadow()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
}
