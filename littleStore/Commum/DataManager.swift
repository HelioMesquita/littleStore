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
      fatalError("impossible to get files")
    }
  }

  static func insertAndUpdateProduct(_ product: Product) {
    do {
      if Disk.exists(product.path, in: .documents) {
        try Disk.remove(product.path, from: .documents)
      }
      try Disk.save(product, to: .documents, as: product.path)
      try addProductInBarcodeList(id: product.id)
    } catch {
      fatalError("impossible to save")
    }
  }

  static func selectProductBy(_ id: String) -> Product {
    do {
      return try Disk.retrieve("products/\(id).json", from: .documents, as: Product.self)
    } catch {
      fatalError("not founded json")
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
