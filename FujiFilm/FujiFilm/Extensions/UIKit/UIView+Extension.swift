//  UIView+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import JGProgressHUD
import UIKit

extension UIView {
    // MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.layer.masksToBounds = newValue > 0
                self?.layer.cornerRadius = newValue
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.layer.borderWidth = newValue
            }
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.layer.borderColor = newValue?.cgColor
            }
        }
	}

    var xOrigin: CGFloat {
        get {
            return frame.origin.x
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.frame.origin.x = newValue
            }
        }
    }

    var yOrigin: CGFloat {
        get {
            return frame.origin.y
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.frame.origin.y = newValue
            }
        }
    }

    var widthValue: CGFloat {
        get {
            return frame.size.width
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.frame.size.width = newValue
            }
        }
    }

    var heightValue: CGFloat {
        get {
            return frame.size.height
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.frame.size.height = newValue
            }
        }
    }

    var underLineColor: CGColor? {
        get {
            return layer.sublayers?.first?.backgroundColor
        }

        set {
            DispatchQueue.main.async { [weak self] in
                self?.layer.sublayers?.forEach {
                    if $0.frame.size.height == 1 {
                        $0.backgroundColor = newValue
                    }
                }
            }
        }
    }

    // MARK: - Functions

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()

        DispatchQueue.main.async { [weak self] in
            guard let this = self else { return }

            border.backgroundColor = color.cgColor
            border.frame = CGRect(
                x: 0,
                y: this.frame.size.height - width,
                width: this.frame.size.width,
                height: width
            )

            this.layer.addSublayer(border)
        }
    }

    func showLoader(message: String? = nil) {
        let hud = JGProgressHUD(style: .dark)
        self.endEditing(false)

        DispatchQueue.main.async {
            hud.textLabel.text = message
            hud.show(in: self)
        }
    }

    func hideLoader() {
        JGProgressHUD.allProgressHUDs(in: self).last?.dismiss()
    }

    func show(success message: String) {
        let hud = JGProgressHUD(style: .dark)

        DispatchQueue.main.async {
            hud.textLabel.text = message
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.show(in: self)
            hud.dismiss(afterDelay: 1.0)
        }
    }

    func show(error message: String) {
        let hud = JGProgressHUD(style: .dark)

        DispatchQueue.main.async {
            hud.textLabel.text = message
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self)
            hud.dismiss(afterDelay: 1.0)
        }
    }

    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        let mask = CAShapeLayer()

        mask.path = path.cgPath
        self.layer.mask = mask
    }

	class func loadFromXIB() -> UIView {
		guard let xibView = Bundle.main.loadNibNamed(
			self.className,
			owner: nil,
			options: nil
		)?.first as? UIView else { fatalError("Could not load view from XIB") }
		return xibView
	}

    func addShadow() {
        // Add Shadow
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = GeneralConstant.SHADOW_OFFSET
        self.layer.shadowRadius = GeneralConstant.SHADOW_RADIUS
        self.layer.shadowOpacity = GeneralConstant.SHADOW_OPACITY

        self.layer.shadowPath = UIBezierPath(
            roundedRect: self.bounds,
            cornerRadius: self.layer.cornerRadius
        ).cgPath
    }
}
