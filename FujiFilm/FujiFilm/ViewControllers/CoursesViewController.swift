import AVFoundation
import UIKit

final class CoursesViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var menuTableView: UITableView!

    private var evnetsEventList: [EventList.Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.registerNib(.workshop)
        menuTableView.calculateCellHeight(estimatedHeight: 80.0)
        menuTableView.hideEmptyAndExtraRows()

        menuTableView.addExtraScrollAt(top: 20.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWorkshop()
    }

    private func getWorkshop() {
        guard let user = UserDefaults.standard.userDetails else { return }
        view.showLoader()
        APIManager().request(
            path: APIPaths.getDistributorWorkshop,
            method: .post,
            extraParams: nil,
            parameters: ["distributor_id": user.result.fldDid],
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                // print(String.init(data: data, encoding: .utf8))
                guard let self = self else { return }
                self.view.hideLoader()
                if let list = try? JSONDecoder().decode(EventList.self, from: data) {
                    self.evnetsEventList.removeAll()
                    self.evnetsEventList = list.result.filter { $0.fldEventType == "C" }
                    self.menuTableView.reloadData()
                } else if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: error.message)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return evnetsEventList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellXibs.workshop.rawValue,
            for: indexPath
            ) as? WorkshopCell else { return WorkshopCell() }

        let result = evnetsEventList[indexPath.row]

        cell.scan = { [weak self] in
            guard let self = self else { return }
            self.showAttendanceController(event: self.evnetsEventList[indexPath.row])
        }

        cell.viewAttendees = { [weak self] in
            guard let self = self else { return }
            self.showAttendanceController(event: self.evnetsEventList[indexPath.row])
        }

        cell.display(result: result)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
