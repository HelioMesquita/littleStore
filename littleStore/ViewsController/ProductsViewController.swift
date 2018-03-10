import UIKit

class ProductsViewController: UITableViewController, ScannerHandable {

  var products = [Product]() {
    didSet {
      self.tableView.reloadData()
    }
  }

  @IBAction func showScanner(_ sender: Any) {
    BarcodeScanner(viewController: self, delegate: self).showScanner()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "productsViewControllerTitle".localized
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    self.products = DataManager.getProducts()
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
    cell.textLabel?.text = products[indexPath.row].name
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
      viewController.product = products[index]
    }
  }

  func insertNewProduct(product: Product) {
    self.products.append(product)
  }
}
