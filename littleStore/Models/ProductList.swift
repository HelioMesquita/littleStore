struct ProductList: Codable {

  static let path = "products.json"

  var products: [Product]
}
