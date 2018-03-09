import XCTest
@testable import littleStore

class ProductTests: XCTestCase {

  var subject: Product!

  override func setUp() {
    super.setUp()
    self.subject = Product(name: "name", price: 1.99, id: "1000-1")
  }

  func testFormatedPrice() {
    XCTAssertEqual(subject.priceFormated, "R$ 1.99")
  }

  func testFormatedPriceNumber() {
    XCTAssertEqual(subject.priceFormatedNumber, "1.99")
  }

  func testSetPrice() {
    self.subject.setPrice(price: 100)
    XCTAssertEqual(subject.priceFormatedNumber, "100.00")
  }
}
