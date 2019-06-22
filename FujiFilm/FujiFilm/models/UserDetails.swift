
import Foundation

struct UserDetails: Codable {
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
        let fldDid: String
        let fldParentID: String
        let fldRole: String?
        let fldSlug: String
        let fldFirstname: String
        let fldFamilyname: String
        let fldBuisnessname: String
        let fldEmail: String
        let fldMobile: String
        let fldPhone: String
        let fldCountry: String
        let fldState: String
        let fldCity: String
        let fldArea: String
        let fldAddress1: String
        let fldAddress2: String
        let fldLandmark: String
        let fldZipcode: String
        let fldLat: String
        let fldLong: String
        let fldCurrency: String
        let fldStatus: String
        let fldUserType: String
        let fldCreatedBy: String
        let fldCreated: String

        var fullName: String {
            return (fldFirstname + " " + fldFamilyname)
        }

        enum CodingKeys: String, CodingKey {
            case fldDid = "fld_did"
            case fldParentID = "fld_parent_id"
            case fldRole = "fld_role"
            case fldSlug = "fld_slug"
            case fldFirstname = "fld_firstname"
            case fldFamilyname = "fld_familyname"
            case fldBuisnessname = "fld_buisnessname"
            case fldEmail = "fld_email"
            case fldMobile = "fld_mobile"
            case fldPhone = "fld_phone"
            case fldCountry = "fld_country"
            case fldState = "fld_state"
            case fldCity = "fld_city"
            case fldArea = "fld_area"
            case fldAddress1 = "fld_address_1"
            case fldAddress2 = "fld_address_2"
            case fldLandmark = "fld_landmark"
            case fldZipcode = "fld_zipcode"
            case fldLat = "fld_lat"
            case fldLong = "fld_long"
            case fldCurrency = "fld_currency"
            case fldStatus = "fld_status"
            case fldUserType = "fld_user_type"
            case fldCreatedBy = "fld_created_by"
            case fldCreated = "fld_created"
        }
    }
}
