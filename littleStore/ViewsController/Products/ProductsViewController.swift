import BarcodeScanner
import UIKit

class ProductsViewController: UITableViewController, ProductLoadable {

  var products = [Product]() {
    didSet {
      self.tableView.reloadData()
    }
  }

  @IBAction func showScanner(_ sender: Any) {
    showScanner()
  }

  @IBAction func closeScanner(_ sender: UIBarButtonItem) {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "navigationController")
    present(viewController, animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "productsViewControllerTitle".localized
    loadProducts()
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
    cell.textLabel?.text = products[indexPath.row].name.capitalized
    cell.detailTextLabel?.text = products[indexPath.row].id
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "detailProduct", sender: indexPath.row)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailProduct" {
      guard let index = sender as? Int else { return }
      let viewController = segue.destination as! ProductsDetailViewController
      viewController.delegate = self
      viewController.product = products[index]
    }
  }

  func loadProducts() {
    self.products = DataManager.selectAllProducts()
  }
}

extension ProductsViewController: BarcodeScannerCodeDelegate, ProductCreateHandable {

  func showScanner() {
    let scanner = BarcodeScannerViewController()
    scanner.codeDelegate = self
    scanner.cameraViewController.barCodeFocusViewType = .oneDimension
    scanner.title = "barcodeView".localized
    scanner.isOneTimeSearch = false
    navigationController?.pushViewController(scanner, animated: true)
  }

  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    AlertDefault.productAlert(with: code, viewController: controller) { name, price in
      self.handleProductAttributes(id: code, name: name, price: price, onSaved: { product in
        DataManager.saveProduct(product)
        self.loadProducts()
        controller.navigationController?.popViewController(animated: true)
      }, onFail: {
        AlertDefault.genericAlert(controller, title: nil, message: nil)
      })
    }
  }
}
