
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
        let fldAddress: String
        let fldAddress1: String
        let fldLandmark: String
        let fldZipcode: String
        let fldPostalcode: String
        let fldLat: String
        let fldLong: String
        let fldActivationlink: String
        let fldStatus: String
        let fldUserType: String
        let fldCreatedBy: String
        let fldParentID: String
        let fldCurrency: String
        let fldCreatedat: String

        enum CodingKeys: String, CodingKey {
            case fldDid = "fld_did"
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
            case fldAddress = "fld_address"
            case fldAddress1 = "fld_address1"
            case fldLandmark = "fld_landmark"
            case fldZipcode = "fld_zipcode"
            case fldPostalcode = "fld_postalcode"
            case fldLat = "fld_lat"
            case fldLong = "fld_long"
            case fldActivationlink = "fld_activationlink"
            case fldStatus = "fld_status"
            case fldUserType = "fld_user_type"
            case fldCreatedBy = "fld_created_by"
            case fldParentID = "fld_parent_id"
            case fldCurrency = "fld_currency"
            case fldCreatedat = "fld_createdat"
        }
    }
}


