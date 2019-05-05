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

        struct Product: Codable, TimestampToDateConvertible {
            var fldEventStarttime: String {
                return self.fldPurchaseDate
            }

            var fldEventEndtime: String {
                return self.fldPWarrantyDate
            }

            var fldEventDate: String {
                return self.fldPWarrantyDate
            }

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

            var fulldetails: [(title: String, subTitle: String)] {
                var list = [(title: String, subTitle: String)]()

                list.append((title: "Customer Name", subTitle: self.clientName))
                list.append((title: "Model Name", subTitle: self.fldModelName))
                list.append((title: "Serial Number", subTitle: self.fldSerialNumber))
                list.append((title: "Purchase Date", subTitle: self.convertToDate(self.fldPurchaseDate) ?? self.fldPurchaseDate))
                list.append((title: "Warranty Remaining", subTitle: self.dayLeft.description + " days"))
                list.append((title: "Purchase From", subTitle: self.distributorName))
                list.append((title: "Purchase City", subTitle: self.city))

                return list
            }
        }
    }
}
