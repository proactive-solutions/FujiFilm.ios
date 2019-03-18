import Foundation

struct ProductWarrantyDetails: Codable {
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
        let product: [Product]

        enum CodingKeys: String, CodingKey {
            case product
        }

        struct Product: Codable {
            let fldModelName: String
            let fldPName: String
            let fldPurchaseDate: String
            let fldPWarrantyDate: String
            let fldSerialNumber: String
            let clientName: String
            let distributorName: String
            let city: String
            let dayLeft: Int

            enum CodingKeys: String, CodingKey {
                case fldModelName = "fld_model_name"
                case fldPName = "fld_p_name"
                case fldPurchaseDate = "fld_purchase_date"
                case fldPWarrantyDate = "fld_p_warranty_date"
                case fldSerialNumber = "fld_serial_number"
                case clientName = "client_name"
                case distributorName = "distributor_name"
                case city
                case dayLeft
            }
        }
    }
}
