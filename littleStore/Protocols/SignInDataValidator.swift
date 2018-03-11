protocol SignInDataValidator {
  func validateSignInFields(name: String?, email: String?, password: String?, passwordCopy: String?)
  func onSuccess(_ user: User)
  func onFail()
}

extension SignInDataValidator {
  func validateSignInFields(name: String?, email: String?, password: String?, passwordCopy: String?) {
    if let nameVerified = name, let emailVerified = email, let passwordVerified = password, let passwordCopyVerified = passwordCopy, passwordVerified == passwordCopyVerified {
      onSuccess(User(name: nameVerified, email: emailVerified, password: passwordVerified))
    } else {
      onFail()
    }
  }
}
