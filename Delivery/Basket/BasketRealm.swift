import Foundation
import RealmSwift

class BasketRealm: Object {
    @objc dynamic var ProductName = String()
    @objc dynamic var ProductImage = Data()
    @objc dynamic var Price = String()
}
