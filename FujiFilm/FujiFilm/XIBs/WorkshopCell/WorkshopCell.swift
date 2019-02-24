//
//  WorkshopCell.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

class WorkshopCell: UITableViewCell {
    var scan: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            [weak self] in
            self?.addShadow()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func scanQRCode(_: UIButton) {
        scan?()
    }
}
