import Alamofire
import Foundation

enum APIPaths: String {
    case login = "/login"
    case forgotPassword = "/ForgotPassword"
    case getDistributorWorkshop = "/getDistributorWorkshop"
    case scanQrCodeByDistributor = "/scanQrCodeByDistributor"
    case getProductWarrantyDetails = "/getProductWarrantyDetails"

    var version: String {
        return "V1"
    }

    var baseURL: String {
        return "http://abir.net/api/"
    }
}

protocol DataConvertible {
    var binaryData: Data { get }
}

extension Data: DataConvertible {
    var binaryData: Data {
        return self
    }
}

extension Array: DataConvertible {
    var binaryData: Data {
        return try! JSONSerialization.data(
            withJSONObject: self,
            options: .prettyPrinted
        )
    }
}

extension String: DataConvertible {
    var binaryData: Data {
        return data(using: String.Encoding.utf8)!
    }
}

extension UIImage: DataConvertible {
    var binaryData: Data {
        return jpegData(compressionQuality: 1.0)!
    }
}

extension URL: DataConvertible {
    var binaryData: Data {
        let data = try? Data(contentsOf: self)
        return data ?? Data()
    }
}

class APIManager: NSObject {
    private var currentDataRequest: DataRequest?

    func cancelRequest() {
        currentDataRequest?.cancel()
    }

    func cancelAllRequest() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { sessionDataTask, uploadData, downloadData in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }

    // MARK: - DataTask

    func request(path: APIPaths, method: HTTPMethod, extraParams: String?, parameters: Parameters?, headers: HTTPHeaders?, success: ((Data, Int) -> Void)?, failure: ((Error) -> Void)?) {
        var url: String = path.baseURL + path.version + path.rawValue
        if let extra = extraParams {
            url += "/" + extra
        }
        let urlEncode = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        currentDataRequest = Alamofire.request(
            urlEncode!, method: method,
            parameters: parameters,
            headers: headers
        ).responseData { response in
            switch response.result {
            case let .success(data):
                success?(data, (response.response?.statusCode)!)
                break
            case let .failure(error):
                failure?(error)
                break
            }
        }
    }
}
