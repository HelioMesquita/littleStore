import Disk

class StoragedDataManager {

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

  static func selectAllProducts() -> [Product] {
    do {
      if existProductList() {
        let productList = try getProductList()
        return productList.products
      } else {
        return [Product]()
      }
    } catch {
      fatalError("product list not available")
    }
  }

  static func saveProduct(_ product: Product) {
    do {
      if existProductList() {
        var productList = try getProductList()
        productList.products.append(product)
        try saveProductList(productList)
      } else {
        try createEmptyProductList()
        var productList = try getProductList()
        productList.products.append(product)
        try saveProductList(productList)
      }
    } catch {
      fatalError("impossible to save product")
    }
  }

  static func updateProduct(where product: Product, updatedProduct: Product) {
    do {
      if existProductList() {
        var productList = try getProductList()
        productList.products = productList.products.filter({ (productStored) -> Bool in
          productStored.id != product.id
        })
        productList.products.append(updatedProduct)
        try saveProductList(productList)
      } else {
        try createEmptyProductList()
        var productList = try getProductList()
        productList.products.append(product)
        try saveProductList(productList)
      }
    } catch {
      fatalError("impossible to update")
    }
  }

  static func selectProductBy(id: String) -> Product? {
    do {
      if existProductList() {
        let productList = try getProductList()
        return productList.products.first(where: { (product) -> Bool in
          product.id == id
        })
      } else {
        return nil
      }
    } catch {
      fatalError("impossible select product")
    }
  }

  private static func existProductList() -> Bool {
    return Disk.exists(ProductList.path, in: .documents)
  }

  private static func getProductList() throws -> ProductList {
    return try Disk.retrieve(ProductList.path, from: .documents, as: ProductList.self)
  }

  private static func saveProductList(_ list: ProductList) throws {
    try Disk.save(list, to: .documents, as: ProductList.path)
  }

  private static func createEmptyProductList() throws {
    let productList = ProductList(products: [Product]())
    try saveProductList(productList)
  }
}
