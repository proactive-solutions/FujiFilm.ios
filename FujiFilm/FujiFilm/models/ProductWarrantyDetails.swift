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
                return self.fldPurchaseDate
            }

            var fldEventDate: String {
                return self.fldPurchaseDate
            }

            let fldModelName: String
            let fldPurchaseDate: String
            let fldWarrantyEndDate: String
            let fldSerial: String?
            let clientName: String
            let dayLeft: Int

            enum CodingKeys: String, CodingKey {
                case fldModelName = "fld_model_name"
                case fldPurchaseDate = "fld_purchase_date"
                case fldWarrantyEndDate = "fld_warranty_end_date"
                case fldSerial = "fld_serial"
                case clientName = "client_name"
                case dayLeft
            }

            var fulldetails: [(title: String, subTitle: String)] {
                var list = [(title: String, subTitle: String)]()

                list.append((title: "Customer Name", subTitle: self.clientName))
                list.append((title: "Model Name", subTitle: self.fldModelName))
                list.append((title: "Serial Number", subTitle: self.fldSerial ?? ""))
                list.append((title: "Purchase Date", subTitle: self.convertToDate(self.fldPurchaseDate) ?? self.fldPurchaseDate))
                list.append((title: "Warranty Remaining", subTitle: self.dayLeft.description + " days"))
                // list.append((title: "Purchase From", subTitle: self.distributorName))
                // list.append((title: "Purchase City", subTitle: self.city))

                return list
            }
        }
    }
}
