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
        let user: User

        enum CodingKeys: String, CodingKey {
            case user
        }

        struct User: Codable, TimestampToDateConvertible {
            var fldEventStarttime: String {
                return (fldCreated.components(separatedBy: " ").last ?? fldCreated)
            }

            var fldEventEndtime: String {
                return (fldCreated.components(separatedBy: " ").last ?? fldCreated)
            }

            var fldEventDate: String {
                return (fldCreated.components(separatedBy: " ").first ?? fldCreated)
            }

            let fldUid: String
            let fldFullname: String
            let fldFamilyname: String
            let fldEmail: String
            let fldPassword: String
            let fldPhone: String
            let fldMobile: String
            let fldDob: String
            let fldGender: String
            let fldUserImage: String
            let fldUserCoverImage: String
            let fldNationality: String
            let fldCountry: String
            let fldState: String
            let fldCity: String
            let fldArea: String
            let fldAddress: String
            let fldAddress1: String
            let fldPo: JSONNull?
            let fldLandmark: String
            let fldZipcode: String
            let fldGear: JSONNull?
            let fldFPSLevel: String
            let fldActivationLink: String
            let fldStatus: String
            let fldUserKey: String
            let fldUserQr: String
            let fldCreatedBy: String
            let fldUserParentID: String
            let fldCreated: String

            enum CodingKeys: String, CodingKey {
                case fldUid = "fld_uid"
                case fldFullname = "fld_fullname"
                case fldFamilyname = "fld_familyname"
                case fldEmail = "fld_email"
                case fldPassword = "fld_password"
                case fldPhone = "fld_phone"
                case fldMobile = "fld_mobile"
                case fldDob = "fld_dob"
                case fldGender = "fld_gender"
                case fldUserImage = "fld_user_image"
                case fldUserCoverImage = "fld_user_cover_image"
                case fldNationality = "fld_nationality"
                case fldCountry = "fld_country"
                case fldState = "fld_state"
                case fldCity = "fld_city"
                case fldArea = "fld_area"
                case fldAddress = "fld_address"
                case fldAddress1 = "fld_address1"
                case fldPo = "fld_po"
                case fldLandmark = "fld_landmark"
                case fldZipcode = "fld_zipcode"
                case fldGear = "fld_gear"
                case fldFPSLevel = "fld_fps_level"
                case fldActivationLink = "fld_activation_link"
                case fldStatus = "fld_status"
                case fldUserKey = "fld_user_key"
                case fldUserQr = "fld_user_qr"
                case fldCreatedBy = "fld_created_by"
                case fldUserParentID = "fld_user_parent_id"
                case fldCreated = "fld_created"
            }
        }
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (_: JSONNull, _: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
