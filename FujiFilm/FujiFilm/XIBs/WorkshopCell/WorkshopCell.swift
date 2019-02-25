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
    @IBOutlet private weak var iconImageView: FujiFilmImageView!
    @IBOutlet private weak var nameLabel: FujiFilmLabel!
    @IBOutlet private weak var dateLabel1: FujiFilmLabel!
    @IBOutlet private weak var dateLabel2: FujiFilmLabel!
    @IBOutlet private weak var dateLabel3: FujiFilmLabel!
    @IBOutlet private weak var attendeeLabel: FujiFilmLabel!
    @IBOutlet private weak var presentLabel: FujiFilmLabel!
    @IBOutlet private weak var absentLabel: FujiFilmLabel!

    var scan: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            [weak self] in
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction private func scanQRCode(_: UIButton) {
        scan?()
    }

    func display(result: EventList.Result) {
        self.dateLabel1.text = result.date
        self.dateLabel2.text = (result.startTime ?? "") + "-" + (result.endTime ?? "")
        self.dateLabel3.text = result.fldEventDuration + " hour"
        self.nameLabel.text = result.fldEventTitle
        self.presentLabel.text = "\(result.attendanceCount)"
        self.attendeeLabel.text = result.fldEventSeat
        self.absentLabel.text = "\(result.remainingAttendanceCount)"
    }
}
