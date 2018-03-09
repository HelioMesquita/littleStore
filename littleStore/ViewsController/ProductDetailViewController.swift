import UIKit

class ProductsDetailViewController: UIViewController {

  var product: Product?

  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var priceField: UITextField!
  @IBOutlet weak var idField: UITextField!
  
  @IBAction func changeValues(_ sender: Any) {
    if let name = nameField.text, let price = priceField.text, let id = idField.text {
      guard let priceNumber = Float(price) else {
        AlertDefault.genericAlert(self, title: "Dados Invalidos", message: "O valor digitado para alterar o preco é invalido")
        return
      }
      product?.updateValues(id: id, name: name, price: priceNumber)
      self.navigationController?.popViewController(animated: true)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Product Detail"
    showProductDetail()
  }

  private func showProductDetail() {
    nameField.text = product?.name
    priceField.text = String(describing: product!.price.rounded())
    idField.text = product?.id
  }
}
