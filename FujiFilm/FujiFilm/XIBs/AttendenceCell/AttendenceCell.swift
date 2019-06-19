import UIKit

class AttendenceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: FujiFilmLabel!
    @IBOutlet weak var markPresentButton: UIButton!

    var markPresent: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func markPresent(_ sender: UIButton) {
        markPresent?()
    }
}
