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

    func upload(isGif: Bool? = false, url: String, method: HTTPMethod, multipartFormData multipartFormDataDict: [String: DataConvertible]? = nil, headers: HTTPHeaders? = nil, success: ((Data, Int) -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormDataDict?.forEach { key, value in
                    if isGif == true, key == "image" {
                        let fileName = UUID().uuidString + ".gif"
                        multipartFormData.append(
                            value.binaryData,
                            withName: key,
                            fileName: fileName,
                            mimeType: "image/gif"
                        )
                    } else {
                        if let v = value as? UIImage {
                            let fileName = UUID().uuidString + ".jpeg"
                            multipartFormData.append(
                                v.binaryData,
                                withName: key,
                                fileName: fileName,
                                mimeType: "image/jpeg"
                            )
                        } else if let v = value as? URL {
                            multipartFormData.append(
                                v,
                                withName: key,
                                fileName: UUID().uuidString + ".mp4",
                                mimeType: "video/mp4"
                            )
                        } else {
                            multipartFormData.append(
                                value.binaryData,
                                withName: key
                            )
                        }
                    }
                }
            },
            to: url,
            method: method,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case let .success(upload, _, _):
                    upload.responseData { response in
                        switch response.result {
                        case .success:
                            success?(response.result.value!, (response.response?.statusCode)!)
                            break
                        case let .failure(error):
                            failure?(error)
                            break
                        }
                    }
                case let .failure(encodingError):
                    failure?(encodingError)
                }
            }
        )
    }

    func download(urlString _: String, destinationPath: String? = nil, success: ((String?) -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        var finalDestination: DownloadRequest.DownloadFileDestination?
        if let path = destinationPath {
            finalDestination = { _, _ in
                (URL(fileURLWithPath: path), [.removePreviousFile, .createIntermediateDirectories])
            }
        }
        Alamofire.download("http://f197504f.ngrok.io/system/users/avatars/000/000/119/original/webrtcArchitecture.png", to: finalDestination).response { response in
            print(response)
            if response.error == nil {
                success?(response.destinationURL?.path)
            } else {
                failure?(response.error!)
            }
        }
    }
}
