import UIKit

class AlertDefault {
  static func productAlert(with id: String, viewController: UIViewController, onSave: @escaping (String?, String?) -> Void) {

    let alertController = UIAlertController(title: "Registrando o produto", message: "insira as informacoes do produto com codigo de barras \(id)", preferredStyle: .alert)

    alertController.addTextField { (textField : UITextField!) -> Void in
      textField.placeholder = "digite o nome do produto"
      textField.textAlignment = .center
    }

    alertController.addTextField { (textField : UITextField!) -> Void in
      textField.placeholder = "digite o valor do produto"
      textField.textAlignment = .center
      textField.keyboardType = .numbersAndPunctuation
    }

    let dismiss = UIAlertAction(title: "cancelar", style: .default) { action in
      viewController.navigationController?.popViewController(animated: true)
    }
    alertController.addAction(dismiss)

    let field = alertController.textFields!
    let save = UIAlertAction(title: "salvar", style: .default) { (action) in
      onSave(field[0].text, field[1].text)
    }
    alertController.addAction(save)

    viewController.present(alertController, animated: true, completion: nil)
  }

  static func genericAlert(_ viewController: UIViewController, title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    let dismiss = UIAlertAction(title: "ok", style: .default, handler: nil)
    alertController.addAction(dismiss)

    viewController.present(alertController, animated: true, completion: {
      viewController.navigationController?.popViewController(animated: true)
    })
  }
}
