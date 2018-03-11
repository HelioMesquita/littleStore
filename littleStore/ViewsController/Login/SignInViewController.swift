import UIKit

class SignInViewController: UIViewController, SignInDataValidator {

  var delegate: SignUpProtocol?

  @IBOutlet weak var fullNameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var reenterPasswoardField: UITextField!

  @IBAction func confirmButton(_ sender: UIButton) {
    validateSignInFields(name: fullNameField.text, email: emailField.text, password: passwordField.text, passwordCopy: reenterPasswoardField.text)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "signinViewController".localized
  }

  func onSuccess(_ user: User) {
    StoragedDataManager.saveUser(user)
    self.delegate?.performLogin()
  }

  func onFail() {
    AlertDefault.genericAlert(self, title: nil, message: nil)
  }
}
