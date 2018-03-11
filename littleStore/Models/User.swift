class User: Codable {
  var name: String
  var email: String
  var password: String

  static var path: String {
    return "storedUser.json"
  }

  init(name: String, email: String, password: String) {
    self.name = name
    self.email = email
    self.password = password
  }

  private enum CodingKeys: String, CodingKey {
    case name
    case email
    case password
  }
}
