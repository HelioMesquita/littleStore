import IQKeyboardManagerSwift
import UIKit
import Disk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    IQKeyboardManager.sharedManager().enable = true
    argumentsForUITest()
    return true
  }

  func argumentsForUITest() {
    if CommandLine.arguments.contains("firstRegister") {
      if Disk.exists(User.path, in: .documents) {
        try! Disk.remove(User.path, from: .documents)
      }
    }
    if CommandLine.arguments.contains("alreadyRegistered") {
      DataManager.saveUser(User(name: "Marcela", email: "marcela@marcela.com.br", password: "1234567"))
    }
    if CommandLine.arguments.contains("editingProduct") {
      if Disk.exists("products/12345678.json", in: .documents) {
        try! Disk.remove("products/12345678.json", from: .documents)
      }
      if Disk.exists("barcodeListPath.json", in: .documents) {
        try! Disk.remove("barcodeListPath.json", from: .documents)
      }
      DataManager.saveProduct(Product(id: "123456789101112", name: "iPhone X", price: 5500))
    }
  }
}

