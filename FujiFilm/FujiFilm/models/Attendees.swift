// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let attendees = try? newJSONDecoder().decode(Attendees.self, from: jsonData)

import Foundation

// MARK: - Attendees

struct Attendees: Codable {
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

    // MARK: - Result

    struct Result: Codable {
        let presentCount: Int
        let absentCount: Int
        let totalSeatCount: String
        let totalSeatRegister: Int
        let attendence: [Attendence]

        enum CodingKeys: String, CodingKey {
            case presentCount = "present_count"
            case absentCount = "absent_count"
            case totalSeatCount = "total_seat_count"
            case totalSeatRegister = "total_seat_register"
            case attendence = "Attendence"
        }

        // MARK: - Attendence

        struct Attendence: Codable {
            let name: String
            let phone: String?
            let eventID: String
            let status: String
            let city: String
            let qrCode: String

            enum CodingKeys: String, CodingKey {
                case name
                case phone
                case eventID = "event_id"
                case status
                case city
                case qrCode = "qr_code"
            }
        }
    }
}
