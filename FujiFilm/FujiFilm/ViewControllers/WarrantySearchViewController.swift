import AVFoundation
import QRCodeReader
import UIKit

class WarrantySearchViewController: FujiFilmViewController, QRCodeReaderViewControllerDelegate {
    @IBOutlet private var serialNumber: FujiFilmButton!
    @IBOutlet private var emailButton: FujiFilmButton!
    @IBOutlet private var productSearchTextField: FujiFilmTextField!

    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }

        return QRCodeReaderViewController(builder: builder)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func seachWarranty(_: FujiFilmButton) {
        if productSearchTextField!.text!.trimmed.count ==  0 {
            view.show(error: "Please enter serial number")
            return
        }

        if self.emailButton.isSelected {
            let params: [String: String] = [
                "serial_no": "",
                "qr_code": "",
                "email_id": productSearchTextField!.text!
            ]
            self.search(params: params)
        } else if serialNumber.isSelected {
            let params: [String: String] = [
                "serial_no":  productSearchTextField!.text!,
                "qr_code": "",
                "email_id": ""
            ]
            self.search(params: params)
        }
    }

    @IBAction func scan(_: FujiFilmButton) {
        readerVC.delegate = self

        // Or by using the closure pattern
        readerVC.completionBlock = { [weak self] (result: QRCodeReaderResult?) in
            if let _result = result?.value {
                let params: [String: String] = [
                    "serial_no": "",
                    "qr_code": _result,
                    "email_id": ""
                ]
                self?.search(params: params)
            }
        }

        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }

    @IBAction func searchViaSerianNumber(_ sender: FujiFilmButton) {
        sender.isSelected = true
        emailButton.isSelected = false
    }

    @IBAction func searhViaEmail(_ sender: FujiFilmButton) {
        sender.isSelected = true
        serialNumber.isSelected = false
    }

    func reader(_ reader: QRCodeReaderViewController, didScanResult _: QRCodeReaderResult) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }

    // This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    // By pressing on the switch camera button
    func reader(_: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        print("Switching capture to: \(newCaptureDevice.device.localizedName)")
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }

    private func search(params: [String: String]) {
        view.showLoader()

        APIManager().request(
            path: APIPaths.getProductWarrantyDetails,
            method: .post,
            extraParams: nil,
            parameters: params,
            headers: nil,
            success: { [weak self] (data: Data, code: Int) in
                guard let self = self else { return }
                self.view.hideLoader()
                if let response = try? JSONDecoder().decode(APIError.self, from: data) {
                    if code == 200 {
                        self.view.show(success: response.message)
                    } else {
                        self.view.show(error: response.message)
                    }
                } else if let theData = try? JSONDecoder().decode(ProductWarrantyDetails.self, from: data) {
                    let vc = self.showWarrantySearchResultViewController()
                    vc.result = theData
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }
}
