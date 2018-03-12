//import XCTest
//import Disk
//@testable import littleStore
//
//class DataManagerTests: XCTestCase {
//
//  override func setUp() {
//    super.setUp()
//    reset()
//  }
//
//  func testSaveProduct() {
//    let product = Product(id: "bananaId", name: "banana", price: 10.0)
//    StoragedDataManager.saveProduct(product)
//    let storedProduct = StoragedDataManager.selectProductBy(id: "bananaId")
//    XCTAssertNotNil(storedProduct, "finded product stored in products list")
//  }
//
//  func testSelectProductSaved() {
//    let product = Product(id: "bananaId", name: "banana", price: 10.0)
//    StoragedDataManager.saveProduct(product)
//
//    let storedProduct = StoragedDataManager.selectProductBy(id: "bananaId")
//    XCTAssertEqual(storedProduct!.name, "banana")
//    XCTAssertEqual(storedProduct!.price, 10.0)
//    XCTAssertEqual(storedProduct!.id, "bananaId")
//  }
//
//  func testUpdateProductSaved() {
//    let product1 = Product(id: "bananaId", name: "banana", price: 10.0)
//    StoragedDataManager.saveProduct(product1)
//
//    let updatedProduct = Product(id: "macaId", name: "maca", price: 20.0)
//    StoragedDataManager.updateProduct(where: product1, updatedProduct: updatedProduct)
//
//    let storedProduct = StoragedDataManager.selectProductBy(id: "macaId")
//    XCTAssertEqual(storedProduct!.name, "maca")
//    XCTAssertEqual(storedProduct!.price, 20)
//    XCTAssertEqual(storedProduct!.id, "macaId")
//  }
//
//  func testRetriveEmptyProductsList() {
//    let products = StoragedDataManager.selectAllProducts()
//    XCTAssertTrue(products.isEmpty)
//  }
//
//  func testRetriveProductsList() {
//    let product1 = Product(id: "bananaId", name: "banana", price: 10.0)
//    let product2 = Product(id: "macaId", name: "maca", price: 10.0)
//
//    StoragedDataManager.saveProduct(product1)
//    StoragedDataManager.saveProduct(product2)
//
//    let products = StoragedDataManager.selectAllProducts()
//    XCTAssertTrue(!products.isEmpty)
//    XCTAssertEqual(products.count, 2)
//  }
//
//  func testSaveUser() {
//    let user = User(name: "joao", email: "joao@joao.com.br", password: "123456")
//    StoragedDataManager.saveUser(user)
//    XCTAssertTrue(Disk.exists(User.path, in: .documents))
//  }
//
//  func testGetEmptyStoredUser() {
//    let user = StoragedDataManager.getStoredUser()
//    XCTAssertNil(user)
//  }
//
//  func testGetStoredUser() {
//    let user = User(name: "joao", email: "joao@joao.com.br", password: "123456")
//    StoragedDataManager.saveUser(user)
//    let userStored = StoragedDataManager.getStoredUser()!
//    XCTAssertEqual(user.name, userStored.name)
//    XCTAssertEqual(user.email, userStored.email)
//    XCTAssertEqual(user.password, userStored.password)
//  }
//
//  override func tearDown() {
//    super.tearDown()
//    reset()
//  }
//
//  func reset() {
//    if Disk.exists(ProductList.path, in: .documents) {
//      try! Disk.remove(ProductList.path, from: .documents)
//    }
//    if Disk.exists(User.path, in: .documents) {
//      try! Disk.remove(User.path, from: .documents)
//    }
//  }
//}

