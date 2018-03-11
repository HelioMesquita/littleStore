import XCTest
import Disk
@testable import littleStore

class DataManagerTests: XCTestCase {

  private let bananaId: String = "1"
  private let appleId: String = "2"

  func testSaveProduct() {
    let product1 = Product(id: bananaId, name: "banana", price: 10.0)
    DataManager.saveProduct(product1)
    XCTAssertTrue(Disk.exists(self.standardPath(bananaId) , in: .documents))
  }

  func testSelectProductSaved() {
    let product1 = Product(id: bananaId, name: "banana", price: 10.0)
    DataManager.saveProduct(product1)

    let product = DataManager.selectProductBy(bananaId)
    XCTAssertEqual(product.name, "banana")
    XCTAssertEqual(product.price, 10.0)
    XCTAssertEqual(product.id, "1")
  }

  func testUpdateProductSaved() {
    let product1 = Product(id: bananaId, name: "banana", price: 10.0)
    DataManager.saveProduct(product1)

    let product2 = Product(id: appleId, name: "maca", price: 20.0)
    DataManager.updateProduct(where: product1, toProduct: product2)

    let product = DataManager.selectProductBy(appleId)
    XCTAssertEqual(product.name, "maca")
    XCTAssertEqual(product.price, 20)
    XCTAssertEqual(product.id, appleId)
  }

  func testRetriveEmptyProductsList() {
    let products = DataManager.getProducts()
    XCTAssertTrue(products.isEmpty)
  }

  func testRetriveProductsList() {
    let product1 = Product(id: bananaId, name: "banana", price: 10.0)
    let product2 = Product(id: appleId, name: "maca", price: 10.0)

    DataManager.saveProduct(product1)
    DataManager.saveProduct(product2)

    let products = DataManager.getProducts()
    XCTAssertTrue(!products.isEmpty)
    XCTAssertEqual(products.count, 2)
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

