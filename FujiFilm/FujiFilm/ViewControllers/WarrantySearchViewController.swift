import AVFoundation
import QRCodeReader
import UIKit

class WarrantySearchViewController: FujiFilmViewController, QRCodeReaderViewControllerDelegate {
    @IBOutlet private var serialNumber: FujiFilmButton!
    @IBOutlet private var emailButton: FujiFilmButton!
    @IBOutlet private var textField: FujiFilmTextField!

    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }

        return QRCodeReaderViewController(builder: builder)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func seachWarranty(_ sender: FujiFilmButton) {
        self.showWarrantySearchResultViewController()
    }

    @IBAction func scan(_ sender: FujiFilmButton) {
        readerVC.delegate = self

        // Or by using the closure pattern
        readerVC.completionBlock = { [weak self] (result: QRCodeReaderResult?) in
            if let _result = result?.value {
                self?.textField.text = result?.value
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
}
