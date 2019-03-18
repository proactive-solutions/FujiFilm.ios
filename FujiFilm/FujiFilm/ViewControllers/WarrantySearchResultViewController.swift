import UIKit

class WarrantySearchResultViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var resultTableView: UITableView!

    private var result: ProductWarrantyDetails? {
        didSet {
            resultTableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        resultTableView.registerNib(.ProductWarrantyCell)
        resultTableView.calculateCellHeight(estimatedHeight: 80.0)
        resultTableView.hideEmptyAndExtraRows()
    }


    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellXibs.WarrantyCell.rawValue,
            for: indexPath
        ) as? WarrantyCell else { return WarrantyCell() }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
