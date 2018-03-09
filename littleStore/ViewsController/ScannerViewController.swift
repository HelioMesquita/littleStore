import UIKit
import BarcodeScanner

protocol ScannerHandable {
  func addNewProduct(product: Product)
}

class ScannerViewController: NSObject, BarcodeScannerCodeDelegate {

  private var viewController: UIViewController
  private var delegate: ScannerHandable

  init(viewController: UIViewController, delegate: ScannerHandable) {
    self.viewController = viewController
    self.delegate = delegate
  }

  func showScanner() {
    let scanner = BarcodeScannerViewController()
    scanner.codeDelegate = self
    scanner.cameraViewController.barCodeFocusViewType = .oneDimension
    scanner.title = "Barcode Scanner"
    viewController.navigationController?.pushViewController(scanner, animated: true)
  }

  internal func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    print("Barcode Data: \(code)")

    AlertDefault.productAlert(with: "code", viewController: controller) { (name, price) in
      self.handlerAlertData(controller: controller, id: code, name: name, price: price)
    }
  }

  private func handlerAlertData(controller: BarcodeScannerViewController, id: String?, name: String?, price: String?) {
    if let product = Product.create(id: id, name: name, price: price) {
      self.delegate.addNewProduct(product: product)
      controller.navigationController?.popViewController(animated: true)
    } else {
      AlertDefault.genericAlert(controller, title: "Ocorreu um erro", message: "informacoes invalidas, tente novamente")
    }
  }
}

