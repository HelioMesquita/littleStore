import XCTest
import Disk
@testable import littleStore

class DataManagerTests: XCTestCase {

  private let bananaId: String = "1"
  private let appleId: String = "2"

  func testRetriveEmptyProductsList() {
    let products = DataManager.getProducts()
    XCTAssertTrue(products.isEmpty)
  }

  func testRetriveProductsList() {
    let _ = Product.save(id: bananaId, name: "banana", price: 10.0)
    let _ = Product.save(id: appleId, name: "maca", price: 10.0)
    let products = DataManager.getProducts()
    XCTAssertTrue(!products.isEmpty)
  }

  func testSelectProductSaved() {
    let _ = Product.save(id: bananaId, name: "banana", price: 10.0)
    let product = DataManager.selectProductBy(bananaId)
    XCTAssertEqual(product.name, "banana")
    XCTAssertEqual(product.price, 10.0)
    XCTAssertEqual(product.id, "1")
  }

  override func tearDown() {
    super.tearDown()
    if Disk.exists(BarcodeList.barcodeListPath, in: .documents) {
      try! Disk.remove(BarcodeList.barcodeListPath, from: .documents)
    }
    if Disk.exists(self.standardPath(bananaId), in: .documents) {
      try! Disk.remove(self.standardPath(bananaId), from: .documents)
    }
    if Disk.exists(self.standardPath(appleId), in: .documents) {
      try! Disk.remove(self.standardPath(appleId), from: .documents)
    }
  }

  func standardPath(_ id: String) -> String {
    return "products/\(id).json"
  }
}
