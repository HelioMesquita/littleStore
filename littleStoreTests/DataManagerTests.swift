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
    let product = Product(id: bananaId, name: "banana", price: 10.0)
    DataManager.saveProduct(product)
    let storedProduct = DataManager.selectProductBy(id: bananaId)
    XCTAssertNotNil(storedProduct, "finded product stored in products list")
  }

  func testSelectProductSaved() {
    let product = Product(id: bananaId, name: "banana", price: 10.0)
    DataManager.saveProduct(product)

    let storedProduct = DataManager.selectProductBy(id: bananaId)
    XCTAssertEqual(storedProduct!.name, "banana")
    XCTAssertEqual(storedProduct!.price, 10.0)
    XCTAssertEqual(storedProduct!.id, "1")
  }

  func testUpdateProductSaved() {
    let product1 = Product(id: bananaId, name: "banana", price: 10.0)
    DataManager.saveProduct(product1)

    let updatedProduct = Product(id: appleId, name: "maca", price: 20.0)
    DataManager.updateProduct(where: product1, updatedProduct: updatedProduct)

    let storedProduct = DataManager.selectProductBy(id: appleId)
    XCTAssertEqual(storedProduct!.name, "maca")
    XCTAssertEqual(storedProduct!.price, 20)
    XCTAssertEqual(storedProduct!.id, appleId)
  }

  func testRetriveEmptyProductsList() {
    let products = DataManager.selectAllProducts()
    XCTAssertTrue(products.isEmpty)
  }

  func testRetriveProductsList() {
    let product1 = Product(id: bananaId, name: "banana", price: 10.0)
    let product2 = Product(id: appleId, name: "maca", price: 10.0)

    DataManager.saveProduct(product1)
    DataManager.saveProduct(product2)

    let products = DataManager.selectAllProducts()
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
    if Disk.exists(ProductList.path, in: .documents) {
      try! Disk.remove(ProductList.path, from: .documents)
    }
    if Disk.exists(User.path, in: .documents) {
      try! Disk.remove(User.path, from: .documents)
    }
  }
}
