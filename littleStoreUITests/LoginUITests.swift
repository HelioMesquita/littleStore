import XCTest

class LoginUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    app = XCUIApplication()
  }

  func testRegisterUser() {
    app.launchArguments.append("firstRegister")
    app.launch()

    app.buttons["Registrar"].tap()
    let element = app.otherElements.containing(.navigationBar, identifier:"Inscreva-se").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    let textField = element.children(matching: .textField).element(boundBy: 0)
    textField.tap()
    textField.typeText("jose")
    
    let textField2 = element.children(matching: .textField).element(boundBy: 1)
    textField2.tap()
    textField2.typeText("jose@jose.com.br")
    
    let secureTextField = element.children(matching: .secureTextField).element(boundBy: 0)
    secureTextField.tap()
    secureTextField.typeText("123456")
    
    let secureTextField2 = element.children(matching: .secureTextField).element(boundBy: 1)

    secureTextField2.tap()
    secureTextField2.typeText("123456")

    app.buttons["Confirmar"].tap()
    let navBar = app.navigationBars["Produtos Cadastrados"]
    XCTAssertTrue(navBar.exists, "Produtos Cadastrados")
  }

  func testRegisterWrongDataUser() {
    app.launchArguments.append("firstRegister")
    app.launch()
    app.buttons["Registrar"].tap()

    let element = app.otherElements.containing(.navigationBar, identifier:"Inscreva-se").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    let textField = element.children(matching: .textField).element(boundBy: 0)
    textField.tap()
    textField.typeText("jose")

    let textField2 = element.children(matching: .textField).element(boundBy: 1)
    textField2.tap()
    textField2.typeText("jose@jose.com.br")

    let secureTextField = element.children(matching: .secureTextField).element(boundBy: 0)
    secureTextField.tap()
    secureTextField.typeText("123")

    let secureTextField2 = element.children(matching: .secureTextField).element(boundBy: 1)

    secureTextField2.tap()
    secureTextField2.typeText("123456")

    app.buttons["Confirmar"].tap()

    let ocorreuUmErroAlert = app.alerts["Ocorreu um Erro"]
    XCTAssertTrue(ocorreuUmErroAlert.exists, "Ocorreu um Erro")
  }

  func testUserAlreadyRegistered() {
    app.launchArguments.append("alreadyRegistered")
    app.launch()
    app.buttons["Entrar"].tap()
    let navBar = app.navigationBars["Produtos Cadastrados"]
    XCTAssertTrue(navBar.exists, "Produtos Cadastrados")
  }
}
