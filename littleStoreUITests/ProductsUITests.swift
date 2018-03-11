import XCTest

class ProductsUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    app = XCUIApplication()
    app.launchArguments.append("alreadyRegistered")
  }

  func testOpenProdutDetailViewController() {
    app.launchArguments.append("editingProduct")
    app.launch()
    app.buttons["Entrar"].tap()
    app.tables.cells.staticTexts["123456789101112"].tap()
    let navBar = app.navigationBars["Detalhe do Produto"]
    XCTAssertTrue(navBar.exists, "Detalhe do Produto")
  }

  func testEditingProdutDetailsViewController() {
    app.launchArguments.append("editingProduct")
    app.launch()
    app.buttons["Entrar"].tap()
    app.tables.cells.staticTexts["123456789101112"].tap()

    let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    let textField = element.children(matching: .textField).element(boundBy: 2)
    textField.tap()
    textField.buttons["Limpar texto"].tap()
    textField.typeText("12345678")
    app.toolbars.buttons["Toolbar Done Button"].tap()
    app.buttons["Alterar"].tap()

    let cell = app.tables.cells.staticTexts["12345678"]
    XCTAssertTrue(cell.exists, "field id in cell")
  }
}
