import CoreGraphics
import Foundation

struct GeneralConstant {
    static var languageChangeNotification: String {
        return " com.fujifilm-xmea.team:ApplangDidChange"
    }

    static var PASSWORD_MIN_LENGTH = 8
    static var PASSWORD_MAX_LENGTH = 20
    static var CORNER_RADIUS: CGFloat { return 5 }
    static var SHADOW_RADIUS: CGFloat { return 1 }
    static var SHADOW_OFFSET: CGSize { return CGSize.zero }
    static var SHADOW_OPACITY: Float = 0.5
}
