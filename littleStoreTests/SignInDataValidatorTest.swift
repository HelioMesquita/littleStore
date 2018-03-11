import XCTest
@testable import littleStore

class SignInDataValidatorTest: XCTestCase {

  class DummySigIn: SignInDataValidator {
    var succeed = false
    var failed = false
    var user: User?

    func onSuccess(_ user: User) {
      self.succeed = true
      self.user = user
    }

    func onFail() {
      self.failed = true
    }
  }

  var subject: DummySigIn!

  override func setUp() {
    super.setUp()
    self.subject = DummySigIn()
  }

  func testRightToCreateAUser() {
    let name: String = "helio"
    let email: String = "helio@helio.com.br"
    let password: String = "123456"
    let passwordCopy: String = "123456"
    subject.validateSignIn(name: name, email: email, password: password, passwordCopy: passwordCopy)

    XCTAssertTrue(subject.succeed)
    XCTAssertEqual(subject.user?.name, name)
    XCTAssertEqual(subject.user?.email, email)
    XCTAssertEqual(subject.user?.password, password)
  }

  func testNotEqualPassword() {
    let name: String = "helio"
    let email: String = "helio@helio.com.br"
    let password: String = "123456"
    let passwordCopy: String = "1234568"
    subject.validateSignIn(name: name, email: email, password: password, passwordCopy: passwordCopy)

    XCTAssertTrue(subject.failed)
  }

  func testEmptyEmail() {
    let name: String = "helio"
    let password: String = "123456"
    let passwordCopy: String = "1234568"
    subject.validateSignIn(name: name, email: nil, password: password, passwordCopy: passwordCopy)

    XCTAssertTrue(subject.failed)
  }

  func testEmptyName() {
    let email: String = "helio@helio.com.br"
    let password: String = "123456"
    let passwordCopy: String = "1234568"
    subject.validateSignIn(name: nil, email: email, password: password, passwordCopy: passwordCopy)

    XCTAssertTrue(subject.failed)
  }
}

