import UIKit

class WarrantySearchResultViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var resultTableView: UITableView!

    var result: ProductWarrantyDetails? {
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
        return result?.result.product.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellXibs.ProductWarrantyCell.rawValue,
            for: indexPath
        ) as? ProductWarrantyCell else { return ProductWarrantyCell() }


        cell.titleLabelText.text = "Model Name"
        cell.subTitleLabelText.text = result?.result.product[indexPath.row].fldModelName

        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        guard let detail = self.result?.result.product[indexPath.row].fulldetails else {
            return
        }

        self.showProductDetailsController(details: detail)
    }
    
}
