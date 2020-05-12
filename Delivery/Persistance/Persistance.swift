import Foundation
import RealmSwift

class Persistance {
    static let shared = Persistance()
    private let realm = try! Realm()

// MARK: -- User
    func addUser() {
    let info = UserInfo()
    try! realm.write
    { realm.add(info) } }
    
    func getUserInfo() -> Results<UserInfo>
    { realm.objects(UserInfo.self) }
    
// MARK: -- Orders
    func addOrder(){
    let product = BasketRealm()
    try! realm.write
    { realm.add(product) }; realm.refresh() }
    
    func getOrders() -> Results<BasketRealm>
    { realm.objects(BasketRealm.self) }
    
    func removeOrder(index: Int){
    let product = realm.objects(BasketRealm.self)[index]
    try! realm.write { realm.delete(product) }; realm.refresh() }
}
