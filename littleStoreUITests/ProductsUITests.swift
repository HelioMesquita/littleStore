import XCTest

class ProductsUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    app = XCUIApplication()
    app.launchArguments.append("alreadyRegistered")
  }

  func testOpenEdidProdutViewController() {
    app.launchArguments.append("editingProduct")
    app.launch()
    app.buttons["Entrar"].tap()
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Iphone X"]/*[[".cells.staticTexts[\"Iphone X\"]",".staticTexts[\"Iphone X\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    let navBar = app.navigationBars["Detalhe do Produto"]
    XCTAssertTrue(navBar.exists, "Detalhe do Produto")
  }

  func testEdidProdutDetailsViewController() {
    app.launchArguments.append("editingProduct")
    app.launch()
    app.buttons["Entrar"].tap()
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["Iphone X"]/*[[".cells.staticTexts[\"Iphone X\"]",".staticTexts[\"Iphone X\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    let textField = element.children(matching: .textField).element(boundBy: 1)
    textField.tap()
    textField.buttons["Limpar texto"].tap()
    textField.typeText("6000")
    app.toolbars.buttons["Toolbar Done Button"].tap()
    app.buttons["Alterar"].tap()
    
    let navBar = app.navigationBars["Produtos Cadastrados"]
    XCTAssertTrue(navBar.exists, "Produtos Cadastrados")
  }
}
