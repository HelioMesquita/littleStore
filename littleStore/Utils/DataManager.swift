import Disk

class DataManager {

  static func getProducts() -> [Product] {
    do {
      if existBarcodeList() {
        let barcodeList = try getBarcodeList()

        var products = [Product]()
        for id in barcodeList.ids {
          products.append(selectProductBy(id))
        }

        return products
      } else {
        return [Product]()
      }
    } catch {
      fatalError("barlist not available")
    }
  }

  static func saveProduct(_ product: Product) {
    do {
      try Disk.save(product, to: .documents, as: product.path)
      try addProductInBarcodeList(id: product.id)
    } catch {
      fatalError("impossible to save product")
    }
  }

  static func saveUser(_ user: User) {
    do {
      try Disk.save(user, to: .documents, as: User.path)
    } catch {
      fatalError("impossible to save user")
    }
  }

  static func getStoredUser() -> User? {
    do {
      if Disk.exists(User.path, in: .documents) {
        return try Disk.retrieve(User.path, from: .documents, as: User.self)
      } else {
        return nil
      }
    } catch {
      fatalError("impossible to check stored user")
    }
  }

  static func updateProduct(where product: Product, updatedProduct: Product) {
    do {
      try Disk.remove(product.path, from: .documents)
      var barcodeList = try getBarcodeList()
      barcodeList.ids = barcodeList.ids.filter({ id -> Bool in
        id != product.id
      })
      barcodeList.ids.append(updatedProduct.id)
      barcodeList.ids = Array(Set(barcodeList.ids))
      try saveBarcodeList(barcodeList)
      saveProduct(updatedProduct)
    } catch {
      fatalError("impossible to update")
    }
  }

  static func selectProductBy(_ id: String) -> Product {
    do {
      return try Disk.retrieve("products/\(id).json", from: .documents, as: Product.self)
    } catch {
      fatalError("json not founded")
    }
  }

  private static func addProductInBarcodeList(id: String) throws {
    if existBarcodeList() {
      var barcodeList = try getBarcodeList()
      barcodeList.ids.append(id)
      barcodeList.ids = Array(Set(barcodeList.ids))
      try saveBarcodeList(barcodeList)
    } else {
      try saveBarcodeList(BarcodeList(ids: [id]))
    }
  }

  private static func existBarcodeList() -> Bool {
    return Disk.exists(BarcodeList.barcodeListPath, in: .documents)
  }

  private static func getBarcodeList() throws -> BarcodeList {
    return try Disk.retrieve(BarcodeList.barcodeListPath, from: .documents, as: BarcodeList.self)
  }

  private static func saveBarcodeList(_ list: BarcodeList) throws {
    try Disk.save(list, to: .documents, as: BarcodeList.barcodeListPath)
  }
}
