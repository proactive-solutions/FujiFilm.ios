
import Foundation

protocol TimestampToDateConvertible {
    var fldEventStarttime: String { get }
    var fldEventEndtime: String { get }
    var fldEventDate: String { get }
}

extension TimestampToDateConvertible {
    var date: String? {
        PPDateFormatter.shared.formatter.dateFormat = "yyyy-mm-dd"
        if let theDate = PPDateFormatter.shared.formatter.date(from: fldEventDate) {
            PPDateFormatter.shared.formatter.dateFormat = "E, MMM d yyyy"
            return PPDateFormatter.shared.formatter.string(from: theDate)
        }
        return nil
    }

    var startTime: String? {
        PPDateFormatter.shared.formatter.dateFormat = "HH:mm:ss"
        if let theDate = PPDateFormatter.shared.formatter.date(from: fldEventStarttime) {
            PPDateFormatter.shared.formatter.dateFormat = "h:mm a"
            return PPDateFormatter.shared.formatter.string(from: theDate)
        }
        return nil
    }

    var endTime: String? {
        PPDateFormatter.shared.formatter.dateFormat = "HH:mm:ss"
        if let theDate = PPDateFormatter.shared.formatter.date(from: fldEventEndtime) {
            PPDateFormatter.shared.formatter.dateFormat = "h:mm a"
            return PPDateFormatter.shared.formatter.string(from: theDate)
        }
        return nil
    }
}

final class PPDateFormatter {
    private init() {}

    static let shared = PPDateFormatter()

    @discardableResult func dateFromTime(interval: TimeInterval) -> String {
        let theDate = Date(timeIntervalSince1970: interval)
        return formatter.string(from: theDate)
    }

    let formatter: DateFormatter = {
        let form = DateFormatter()
        form.dateFormat = "yyyy-mm-dd"
        return form
    }()
}

