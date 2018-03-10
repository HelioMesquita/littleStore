import UIKit
import BarcodeScanner

class BarcodeScanner: BarcodeScannerCodeDelegate, ProductCreateHandable {

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
    scanner.title = "barcodeView".localized
    viewController.navigationController?.pushViewController(scanner, animated: true)
  }

  internal func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    AlertDefault.productAlert(with: code, viewController: controller) { name, price in
      self.handleProductAttributes(id: code, name: name, price: price, onSaved: { product in
        DataManager.insertAndUpdateProduct(product)
        self.delegate.insertNewProduct(product: product)
        controller.navigationController?.popViewController(animated: true)
      }, onFail: {
        AlertDefault.genericAlert(controller, title: nil, message: nil)
      })
    }
  }
}


