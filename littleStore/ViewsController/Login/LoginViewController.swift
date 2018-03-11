import UIKit

class LoginViewController: UIViewController, SignUpProtocol {

  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBAction func signUpButton(_ sender: UIButton) {
    prepareForLogin(emailField: emailField.text, passwordField: passwordField.text, userStored: DataManager.getStoredUser())
  }

  @IBAction func signInButton(_ sender: UIButton) {
    performSegue(withIdentifier: "singInViewController", sender: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let user = DataManager.getStoredUser()
    emailField.text = user?.email
    passwordField.text = user?.password
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "singInViewController" {
      let viewController = segue.destination as! SignInViewController
      viewController.delegate = self
    }
  }

  func performLogin() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "navigationController")
    present(viewController, animated: true, completion: nil)
  }

  func loginError() {
    AlertDefault.genericAlert(self, title: nil, message: nil)
  }
}
