import UIKit

class AlertDefault {
  static func productAlert(with id: String, viewController: UIViewController, onSave: @escaping (String?, String?) -> Void) {

    let alertController = UIAlertController(title: "alertCreateProductTitle".localized, message: "alertCreateProductMessage".localized, preferredStyle: .alert)

    alertController.addTextField { textField in
      textField.placeholder = "alertCreateProductNameField".localized
      textField.textAlignment = .center
    }

    alertController.addTextField { textField in
      textField.placeholder = "alertCreateProductPriceField".localized
      textField.textAlignment = .center
      textField.keyboardType = .numbersAndPunctuation
    }

    let dismiss = UIAlertAction(title: "buttonSave".localized, style: .default) { action in
      viewController.navigationController?.popViewController(animated: true)
    }
    alertController.addAction(dismiss)

    let field = alertController.textFields!
    let save = UIAlertAction(title: "buttonCancel".localized, style: .default) { (action) in
      onSave(field[0].text, field[1].text)
    }
    alertController.addAction(save)

    viewController.present(alertController, animated: true, completion: nil)
  }

  static func genericAlert(_ viewController: UIViewController, title: String?, message: String?) {
    let alertController = UIAlertController(title: title ?? "alertGenericTitle".localized, message: message ?? "alertGenericMessage".localized, preferredStyle: .alert)

    let dismiss = UIAlertAction(title: "ok", style: .default, handler: nil)
    alertController.addAction(dismiss)

    viewController.present(alertController, animated: true, completion: {
      viewController.navigationController?.popViewController(animated: true)
    })
  }
}
