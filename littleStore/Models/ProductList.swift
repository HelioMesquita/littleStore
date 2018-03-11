struct ProductList: Codable {

  static let path = "products.json"

  var ids: [String]
  var products: [Product]
}
