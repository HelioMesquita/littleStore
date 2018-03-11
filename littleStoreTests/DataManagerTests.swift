import XCTest
import Disk
@testable import littleStore

class DataManagerTests: XCTestCase {

  private let bananaId: String = "1"
  private let appleId: String = "2"

  override func setUp() {
    super.setUp()
    reset()
  }

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

  func testSaveUser() {
    let user = User(name: "joao", email: "joao@joao.com.br", password: "123456")
    DataManager.saveUser(user)
    XCTAssertTrue(Disk.exists(User.path, in: .documents))
  }

  func testGetEmptyStoredUser() {
    let user = DataManager.getStoredUser()
    XCTAssertNil(user)
  }

  func testGetStoredUser() {
    let user = User(name: "joao", email: "joao@joao.com.br", password: "123456")
    DataManager.saveUser(user)
    let userStored = DataManager.getStoredUser()!
    XCTAssertEqual(user.name, userStored.name)
    XCTAssertEqual(user.email, userStored.email)
    XCTAssertEqual(user.password, userStored.password)
  }

  override func tearDown() {
    super.tearDown()
    reset()
  }

  func reset() {
    if Disk.exists(BarcodeList.barcodeListPath, in: .documents) {
      try! Disk.remove(BarcodeList.barcodeListPath, from: .documents)
    }
    if Disk.exists(self.standardPath(bananaId), in: .documents) {
      try! Disk.remove(self.standardPath(bananaId), from: .documents)
    }
    if Disk.exists(self.standardPath(appleId), in: .documents) {
      try! Disk.remove(self.standardPath(appleId), from: .documents)
    }
    if Disk.exists(User.path, in: .documents) {
      try! Disk.remove(User.path, from: .documents)
    }
  }

  func standardPath(_ id: String) -> String {
    return "products/\(id).json"
  }
}

