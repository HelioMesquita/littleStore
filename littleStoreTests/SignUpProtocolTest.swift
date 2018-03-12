//import XCTest
//@testable import littleStore
//
//class SignInProtocolTest: XCTestCase {
//
//  class DummySigUp: SignUpProtocol {
//    var perfomadedLogin = false
//    var loginFailed = false
//
//    func performLogin() {
//      perfomadedLogin = true
//    }
//
//    func loginError() {
//      loginFailed = true
//    }
//  }
//
//  var subject: DummySigUp!
//
//  override func setUp() {
//    super.setUp()
//    self.subject = DummySigUp()
//  }
//
//  func testPerformLoginWithRightData() {
//    let name: String = "helio"
//    let email: String = "helio@helio.com.br"
//    let password: String = "123456"
//
//    let userStored = User(name: name, email: email, password: password)
//
//    subject.prepareForLogin(emailField: email, passwordField: password, userStored: userStored)
//    XCTAssertTrue(subject.perfomadedLogin)
//  }
//
//  func testWrongEmail() {
//    let name: String = "helio"
//    let email: String = "helio@helio.com.br"
//    let password: String = "123456"
//
//    let userStored = User(name: name, email: "test@test.com.br", password: password)
//
//    subject.prepareForLogin(emailField: email, passwordField: password, userStored: userStored)
//    XCTAssertTrue(subject.loginFailed)
//  }
//
//  func testWrongPassword() {
//    let name: String = "helio"
//    let email: String = "helio@helio.com.br"
//    let password: String = "123456"
//
//    let userStored = User(name: name, email: email, password: "1234567")
//
//    subject.prepareForLogin(emailField: email, passwordField: password, userStored: userStored)
//    XCTAssertTrue(subject.loginFailed)
//  }
//}

