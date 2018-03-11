import Foundation

class Product: Codable {
  private(set) var id: String
  private(set) var name: String
  private(set) var price: Float

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
}
