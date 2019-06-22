import UIKit

final class FujiFilmNavigationBar: UINavigationBar {
    override func awakeFromNib() {
        super.awakeFromNib()
        customize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }

    private func customize() {
        barStyle = .default
        backIndicatorImage = UIImage()
        backIndicatorTransitionMaskImage = UIImage()
        tintColor = UIColor.black
        barTintColor = UIColor.black
        backgroundColor = UIColor.red

        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false

        titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.font(style: .medium, size: 16.0),
        ]
    }
}
