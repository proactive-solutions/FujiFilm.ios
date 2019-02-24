import Foundation

struct APIError: Codable {
    let code: Int
    let success: Bool
    let message: String
    let result: [String]
}
