import Foundation
import RealmSwift

class UserInfo: Object {
    @objc dynamic var name: String = "Иван"
    @objc dynamic var surname: String = "Иванов"
    @objc dynamic var mobile: String = ""
    @objc dynamic var imageData = Data()
    @objc dynamic var money = 0
    @objc dynamic var portacheno = 0
    @objc dynamic var orders = 0
}
