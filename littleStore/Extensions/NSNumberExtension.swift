import Foundation

extension NSNumber {
  var formatNumberAsDecimal : String {
    let formater = NumberFormatter()
    formater.maximumFractionDigits = 2
    formater.minimumFractionDigits = 2
    return formater.string(from: self)!
  }
}
