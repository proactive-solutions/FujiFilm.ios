//  UIImageView+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import SDWebImage
import UIKit.UIImageView

extension UIImageView {
    func from(url: String, completion: ((UIImage) -> Void)?) {
        let imageURL = URL(string: url)
        sd_setImage(
            with: imageURL,
            placeholderImage: #imageLiteral(resourceName: "workshop_placeholder"),
            options: SDWebImageOptions.continueInBackground) {
            image, _, _, _ in
            if let theImage = image {
                completion?(theImage)
            }
        }
    }

    func cancelImageDownload() {
        sd_cancelCurrentImageLoad()
    }

    /// Renders image with given color
    ///
    /// - Parameter colorToSet: Color to use for rendering image.
    @discardableResult func renderWithColor(_ colorToSet: UIColor?) -> UIImageView {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = colorToSet
        return self
    }
}
