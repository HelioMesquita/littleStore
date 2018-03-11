protocol SignUpProtocol {
  func prepareForLogin(emailField: String?, passwordField: String?, userStored: User?)
  func performLogin()
  func loginError()
}

extension SignUpProtocol {
  func prepareForLogin(emailField: String?, passwordField: String?, userStored: User?) {
    if let email = emailField, let password = passwordField, let userStored = userStored {
      if email == userStored.email && password == userStored.password {
        performLogin()
      } else {
        loginError()
      }
    } else {
      loginError()
    }
  }
}
