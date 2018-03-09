import Foundation

class Product: Codable {
  private(set) var id: String
  private(set) var name: String
  private(set) var price: Float

  var path: String {
    return "products/\(id).json"
  }

  init(id: String, name: String, price: Float) {
    self.id = id
    self.name = name
    self.price = price
  }

  static func create(id: String?, name: String?, price: String?) -> Product? {
    if let id = id, let name = name, let price = price, let priceNumber = Float(price) {
      let product = Product(id: id, name: name, price: priceNumber)
      DataManager.insertAndUpdateProduct(product)
      return product
    } else {
      return nil
    }
  }

  func updateValues(id: String, name: String, price: Float) {
    self.id = id
    self.name = name
    self.price = price
    DataManager.insertAndUpdateProduct(self)
  }

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case price
  }
}
