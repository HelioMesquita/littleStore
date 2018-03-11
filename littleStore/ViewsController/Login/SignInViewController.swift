import UIKit

class SignInViewController: UIViewController, SignInDataValidator {

  @IBOutlet weak var fullNameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var reenterPasswoardField: UITextField!

  @IBAction func confirmButton(_ sender: UIButton) {
    validateSignIn(name: fullNameField.text, email: emailField.text, password: passwordField.text, passwordCopy: reenterPasswoardField.text)
  }

  func onSuccess(_ user: User) {

  }

  func onFail() {

  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "signinViewController".localized
  }

}
