import UIKit

class AttendenceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: FujiFilmLabel!
    @IBOutlet weak var markPresentButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!
    
    var markPresent: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction private func markPresent(_ sender: UIButton) {
        markPresent?()
    }

    @IBAction private func callAttendee(_ sender: UIButton) {
        if let num = sender.title(for: .normal) {
            guard let number = URL(string: "tel://" + num) else { return }
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
    }
}
