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

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case price
  }

  static func save(id: String, name: String, price: Float) -> Product {
    let product = Product(id: id, name: name, price: price)
    DataManager.saveAndUpdateProduct(product)
    return product
  }

  func update(id: String, name: String, price: Float) {
    self.id = id
    self.name = name
    self.price = price
    DataManager.saveAndUpdateProduct(self)
  }
}
