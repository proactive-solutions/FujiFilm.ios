import UIKit

class AttendenceViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    private enum ListMode {
        case present
        case absent
        case registered
        case waitingList
    }

    @IBOutlet private var attendenceTableView: FujiFilmTableView!
    private let cellReuseIdentifier = TableViewCellXibs.AttendenceCell.rawValue

    var eventDetails: EventList.Result?
    private var absentUsers: [Attendees.Result.Attendence]?
    private var presentUsers: [Attendees.Result.Attendence]?
    private var waitingUsers: [Attendees.Result.Attendence]?
    private var registeredUsers: [Attendees.Result.Attendence]?
    private var renderingList: [Attendees.Result.Attendence]? {
        didSet {
            attendenceTableView?.reloadData()
        }
    }

    private var listMode: ListMode = .registered

    @IBOutlet private var allUsersButton: UIButton!
    @IBOutlet private var presentUsersButton: UIButton!
    @IBOutlet private var absentUsersButton: UIButton!
    @IBOutlet private var waitingUsersButton: UIButton!

    private var tabMenuButtons: [UIButton]! {
        return [allUsersButton, presentUsersButton, absentUsersButton, waitingUsersButton]
    }

    private var present: String { return "Present" }
    private var absent: String { return "Absent" }
    private var registered: String { return "Registered" }
    private var waiting: String { return "Waiting" }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        attendenceTableView
            .registerNib(.AttendenceCell)
            .calculateCellHeight(estimatedHeight: 80.0)
            .hideEmptyAndExtraRows()

        addUnderLineLayer()

        getAttendees()
    }

    private func addUnderLineLayer() {
        tabMenuButtons.forEach {
            $0.addBottomBorderWithColor(color: .clear, width: 1.0)
        }
        tabMenuButtons?.first?.underLineColor = UIColor.defaultBlue.cgColor
    }

    @IBAction private func presentUser(_ sender: UIButton) {
        resetButtonsunserLineColor()
        sender.underLineColor = UIColor.defaultBlue.cgColor
        listMode = .present
        renderingList = presentUsers
    }

    @IBAction private func absentUser(_ sender: UIButton) {
        resetButtonsunserLineColor()
        sender.underLineColor = UIColor.defaultBlue.cgColor
        listMode = .absent
        renderingList = absentUsers
    }

    @IBAction private func registeredUser(_ sender: UIButton) {
        resetButtonsunserLineColor()
        sender.underLineColor = UIColor.defaultBlue.cgColor
        listMode = .registered
        renderingList = registeredUsers
    }

    @IBAction private func waitingListUser(_ sender: UIButton) {
        resetButtonsunserLineColor()
        sender.underLineColor = UIColor.defaultBlue.cgColor
        listMode = .waitingList
        renderingList = waitingUsers
    }

    private func resetButtonsunserLineColor() {
        tabMenuButtons.forEach { $0.underLineColor = UIColor.clear.cgColor }
    }

    private func getAttendees() {
        guard let user = UserDefaults.standard.userDetails,
            let eveId = self.eventDetails?.fldEventID else { return }

        view.showLoader()
        APIManager().request(
            path: APIPaths.getWorkshopDetails,
            method: .post,
            extraParams: nil,
            parameters: [
                "distributor_id": user.result.fldDid,
                "event_id": eveId
            ],
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                guard let self = self else { return }
                self.view.hideLoader()
                if let details = try? JSONDecoder().decode(Attendees.self, from: data) {
                    self.registeredUsers = details.result.attendence

                    self.absentUsers = details.result.attendence.filter {
                        $0.status.lowercased() == self.absent.lowercased()
                    }

                    self.presentUsers = details.result.attendence.filter {
                        $0.status.lowercased() == self.present.lowercased()
                    }

                    self.waitingUsers = details.result.attendence.filter {
                        $0.status.lowercased() == self.waiting.lowercased()
                    }

                    self.renderingList = details.result.attendence

                    self.attendenceTableView.reloadData()
                } else if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: error.message)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }

    private func markPresent(data: [String: Any]) {
        view.showLoader()
        APIManager().request(
            path: APIPaths.scanQrCodeByDistributor,
            method: .post,
            extraParams: nil,
            parameters: data,
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                guard let self = self else { return }
                print(String(data: data, encoding: String.Encoding.utf8)!)
                self.view.hideLoader()
                if let details = try? JSONDecoder().decode(Attendees.self, from: data) {
                    self.absentUsers = details.result.attendence.filter {
                        $0.status.lowercased() == self.absent.lowercased()
                    }

                    self.presentUsers = details.result.attendence.filter {
                        $0.status.lowercased() == self.present.lowercased()
                    }

                    self.waitingUsers = details.result.attendence.filter {
                        $0.status.lowercased() == self.waiting.lowercased()
                    }

                    self.attendenceTableView.reloadData()
                } else if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: error.message)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let counter = renderingList?.count {
            if counter == 0 {
                attendenceTableView.isHidden = true
            } else {
                attendenceTableView.isHidden = false
            }
            return counter
        }
        attendenceTableView.isHidden = true
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: self.cellReuseIdentifier
        ) as? AttendenceCell else {
            return AttendenceCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }

        switch listMode {
        case .present:
            cell.markPresent = nil
            cell.markPresentButton.isHidden = true
            if let data = renderingList?[indexPath.row] {
                cell.nameLabel?.text = data.name
                cell.phoneNumberButton.setTitle(data.phone, for: .normal)
            }
            break

        case .registered:
            if let data = renderingList?[indexPath.row] {
                guard let user = UserDefaults.standard.userDetails else { fatalError("user not found") }

                cell.nameLabel?.text = data.name
                cell.phoneNumberButton.setTitle(data.phone, for: .normal)
                cell.markPresentButton.isHidden = false
                cell.markPresent = { [weak self] in
                    guard let self = self else { return }

                    let apiData: [String: Any] = [
                        "qr_code": data.qrCode,
                        "distributor_id": user.result.fldDid,
                        "event_id": data.eventID,
                        "type": "M"
                    ]

                    self.markPresent(data: apiData)
                }
            } else {
                cell.markPresent = nil
            }
            break

        case .absent:
            if let data = self.renderingList?[indexPath.row] {
                guard let user = UserDefaults.standard.userDetails else { fatalError("user not found") }

                cell.nameLabel?.text = data.name
                cell.phoneNumberButton.setTitle(data.phone, for: .normal)
                cell.markPresentButton.isHidden = false
                cell.markPresent = { [weak self] in
                    guard let self = self else { return }

                    let apiData: [String: Any] = [
                        "qr_code": data.qrCode,
                        "distributor_id": user.result.fldDid,
                        "event_id": data.eventID,
                        "type": "M"
                    ]

                    self.markPresent(data: apiData)
                }
            } else {
                cell.markPresent = nil
            }
            break

        case .waitingList:
            if let data = self.renderingList?[indexPath.row] {
                guard let user = UserDefaults.standard.userDetails else { fatalError("user not found") }

                cell.nameLabel?.text = data.name
                cell.phoneNumberButton.setTitle(data.phone, for: .normal)
                cell.markPresentButton.isHidden = false
                cell.markPresent = { [weak self] in
                    guard let self = self else { return }

                    let apiData: [String: Any] = [
                        "qr_code": data.qrCode,
                        "distributor_id": user.result.fldDid,
                        "event_id": data.eventID,
                        "type": "M"
                    ]

                    self.markPresent(data: apiData)
                }
            } else {
                cell.markPresent = nil
            }
            break
        }
        return cell
    }
}
