import XCTest
@testable import littleStore

class ProductTests: XCTestCase {

  var subject: Product!

  override func setUp() {
    super.setUp()
    subject = Product(id: "100", name: "Banana", price: 10)
  }

  func testPath() {
    XCTAssertEqual(subject.path, "products/100.json")
  }
}
