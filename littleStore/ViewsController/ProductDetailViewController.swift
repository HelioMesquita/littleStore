import UIKit

class ProductsDetailViewController: UIViewController, ProductCreateHandable {

  var product: Product?

  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var priceField: UITextField!
  @IBOutlet weak var idField: UITextField!
  
  @IBAction func changeValues(_ sender: Any) {
    handleProductAttributes(id: idField.text, name: nameField.text, price: priceField.text, onSaved: { product in
      self.product?.update(id: product.id, name: product.name, price: product.price)
      self.navigationController?.popViewController(animated: true)
    }, onFail: {
      AlertDefault.genericAlert(self, title: nil, message: nil)
    })
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "productDetailViewControllerTitle".localized
    showProductDetail()
  }

  private func showProductDetail() {
    nameField.text = product?.name
    priceField.text = String(describing: product!.price.rounded())
    idField.text = product?.id
  }
}
