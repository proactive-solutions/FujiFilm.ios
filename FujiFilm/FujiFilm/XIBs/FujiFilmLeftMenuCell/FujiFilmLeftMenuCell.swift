//
//  FujiFilmLeftMenuCell.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

class FujiFilmLeftMenuCell: UITableViewCell {
    @IBOutlet var menuTitleLabel: FujiFilmLabel!
    @IBOutlet var menuIconImageView: FujiFilmImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
