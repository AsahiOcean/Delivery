import UIKit
import RealmSwift

public let defaultPhoto = UIImage(named: "defaultPhoto")

class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var UserPhoto: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    
    private let realm = try! Realm()
    var info: Results<UserInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userinfo = self.realm.objects(UserInfo.self)
        UserName.text = "\(userinfo.first!.name)" + " \(userinfo.first!.surname)"
        if userinfo.first!.imageData.isEmpty {
            UserPhoto.image = defaultPhoto
        } else {
            UserPhoto.image = UIImage(data: userinfo.first!.imageData)
        }
    }
    
// MARK: -- User Photo
    @IBAction func ChangePhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Откуда?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Сделать фото", style:
            .default, handler: { _ in self.MakePhoto() }))
        alert.addAction(UIAlertAction(title: "Из галереи", style:
            .default, handler: { _ in self.OpenGallery() }))
        alert.addAction(UIAlertAction.init(title: "Отмена", style:
            .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    private func MakePhoto() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
    let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    } else {
        let alert  = UIAlertController(title: "", message: "Переверните компуктер", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
    
     private func OpenGallery() {
     if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    } else {
        let alert  = UIAlertController(title: "", message: "Нет доступа к галерее", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        if let compressImage = selectedImage.jpeg(.lowest) {
            UserPhoto.image = UIImage(data: compressImage)
        }
        UserPhoto.contentMode = .scaleToFill
    }
        picker.dismiss(animated: true, completion: nil)
    }
}
