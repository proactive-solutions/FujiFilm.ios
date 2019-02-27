// To parse the JSON, add this file to your project and do:
//
//   let qRSaveSuccess = try? newJSONDecoder().decode(QRSaveSuccess.self, from: jsonData)

import Foundation

struct QRSaveSuccess: Codable {
    let code: Int
    let success: Bool
    let message: String
    let result: Result

    enum CodingKeys: String, CodingKey {
        case code
        case success
        case message
        case result
    }

    struct Result: Codable {
        let attendanceCount: Int
        let eventCount: String

        enum CodingKeys: String, CodingKey {
            case attendanceCount = "attendance_count"
            case eventCount = "event_count"
        }
    }
}
