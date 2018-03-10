import XCTest
import Disk
@testable import littleStore

class ProductTests: XCTestCase {

  private let bananaId: String = "1"
  private let appleId: String = "2"

  func testCreateProduct() {
    let _ = Product.save(id: bananaId, name: "banana", price: 10.0)
    XCTAssertTrue(Disk.exists(self.standardPath(bananaId) , in: .documents))
  }

  func testUpdateProductSaved() {
    let productBanana = Product.save(id: bananaId, name: "banana", price: 10.0)
    productBanana.update(id: appleId, name: "maca", price: 20)
    let product = DataManager.selectProductBy(appleId)
    XCTAssertEqual(product.name, "maca")
    XCTAssertEqual(product.price, 20)
    XCTAssertEqual(product.id, appleId)
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

