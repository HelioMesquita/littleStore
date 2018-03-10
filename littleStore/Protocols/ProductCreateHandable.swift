protocol ProductCreateHandable {
  func handleProductAttributes(id: String?, name: String?, price: String?, onSaved: (Product) -> Void, onFail: () -> Void)
}

extension ProductCreateHandable {
  func handleProductAttributes(id: String?, name: String?, price: String?, onSaved: (Product) -> Void, onFail: () -> Void) {
    if let id = id, let name = name, let price = price, let priceNumber = Float(price) {
      onSaved(Product(id: id, name: name, price: priceNumber))
    } else {
      onFail()
    }
  }
}
