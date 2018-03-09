import UIKit

class ProductsViewController: UITableViewController, ScannerHandable {

  func addNewProduct(product: Product) {
    self.products.append(product)
  }


  var products = [Product]() {
    didSet {
      self.tableView.reloadData()
    }
  }

  @IBAction func showScanner(_ sender: Any) {
    openScannerViewController()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    self.products = DataManager.getProducts()
  }

  private func openScannerViewController() {
    ScannerViewController(viewController: self, delegate: self).showScanner()
    //    let viewController = BarcodeScannerViewController()
    //    viewController.codeDelegate = self
    //    viewController.cameraViewController.barCodeFocusViewType = .oneDimension
    //    viewController.title = "Barcode Scanner"
    //    navigationController?.pushViewController(viewController, animated: true)
  }
}

//extension ProductsViewController: BarcodeScannerCodeDelegate {
//
//  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
//    print("Barcode Data: \(code)")
//
//    AlertDefault.productAlert(with: "code", viewController: self) { (name, price) in
//      self.handlerAlertData(controller: controller, id: code, name: name, price: price)
//    }
//  }
//
//  final private func handlerAlertData(controller: BarcodeScannerViewController, id: String?, name: String?, price: String?) {
//    if let product = Product.create(id: id, name: name, price: price) {
//      self.products.append(product)
//      controller.navigationController?.popViewController(animated: true)
//    } else {
//      AlertDefault.genericAlert(self, title: "Ocorreu um erro", message: "informacoes invalidas, tente novamente")
//    }
//  }
//}

extension ProductsViewController {

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
      let product = products[index]
      viewController.product = product
    }
  }
}
