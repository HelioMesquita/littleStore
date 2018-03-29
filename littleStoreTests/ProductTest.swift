import XCTest
@testable import littleStore

class ProductListTests: XCTestCase {

  func testPath() {

    XCTAssertEqual(ProductList.path, "products1.json")
  }
}
