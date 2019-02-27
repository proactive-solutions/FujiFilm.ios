//
//  WorkshopCell.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

extension String {
    var intVal: Int {
        return (self as NSString).integerValue
    }
}

class WorkshopCell: UITableViewCell {
    @IBOutlet private var outerWrapperView: UIView!
    @IBOutlet private var iconImageView: FujiFilmImageView!
    @IBOutlet private var nameLabel: FujiFilmLabel!
    @IBOutlet private var dateLabel1: FujiFilmLabel!
    @IBOutlet private var dateLabel2: FujiFilmLabel!
    @IBOutlet private var dateLabel3: FujiFilmLabel!
    @IBOutlet private var attendeeLabel: FujiFilmLabel!
    @IBOutlet private var presentLabel: FujiFilmLabel!
    @IBOutlet private var absentLabel: FujiFilmLabel!

    var scan: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        applyShadoEffect()

        outerWrapperView.addShadow()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.cancelImageDownload()
        applyShadoEffect()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func applyShadoEffect() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.outerWrapperView.addShadow()
        }
    }

    @IBAction private func scanQRCode(_: UIButton) {
        scan?()
    }

    func display(result: EventList.Result) {
        dateLabel1.text = result.date
        dateLabel2.text = (result.startTime ?? "") + "-" + (result.endTime ?? "")
        dateLabel3.text = result.fldEventDuration + " hour"
        nameLabel.text = result.fldEventTitle
        presentLabel.text = "\(result.attendanceCount)"
        attendeeLabel.text = result.fldEventSeat
        absentLabel.text = "\(result.remainingAttendanceCount)"
        iconImageView.from(url: result.fldEventImage, completion: nil)
    }
}
