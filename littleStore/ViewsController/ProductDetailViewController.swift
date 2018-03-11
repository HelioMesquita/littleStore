import UIKit

class ProductsDetailViewController: UIViewController, ProductCreateHandable {

  var product: Product?
  var delegate: ProductLoadable?

  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var priceField: UITextField!
  @IBOutlet weak var idField: UITextField!
  
  @IBAction func changeValues(_ sender: Any) {
    handleProductAttributes(id: idField.text, name: nameField.text, price: priceField.text, onSaved: { newProduct in
      DataManager.updateProduct(where: product!, toProduct: newProduct)
      self.delegate?.loadProducts()
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
