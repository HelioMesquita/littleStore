import XCTest
@testable import littleStore

class ProductCreateHandableTest: XCTestCase, ProductCreateHandable {

  func testRightDataToCreateAProduct() {
    handleProductAttributes(id: "1", name: "banana", price: "10.1", onSaved: { product in
      XCTAssertEqual(product.id, "1")
      XCTAssertEqual(product.name, "banana")
      XCTAssertEqual(product.price, 10.1)
    }, onFail: {
      XCTFail()
    })
  }

  func testWrongDataToCreateAProduct() {
    handleProductAttributes(id: "1", name: "banana", price: "mil reais", onSaved: { product in
      XCTFail()
    }, onFail: {
      XCTAssertTrue(true, "fail when created")
    })
  }

}
