import UIKit

class OrderVC: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var WebGif: UIWebView!
    
    let Url: NSURL = NSURL(string: "https://i.gifer.com/embedded/download/Q5A.gif")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.Status.frame = .zero
        self.Status.text = "Ищем ближайший к Вам ресторан..."
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        let webRequest : NSURLRequest = NSURLRequest(url: Url as URL)
        WebGif.delegate = self
        WebGif.loadRequest(webRequest as URLRequest)
    }
    
    var timer: Timer?
    
    @objc func timerFunc() {
    if SeeOrderView == true {
        self.Status.text = "Мы готовим Ваш заказ!"
        self.Status.font = .boldSystemFont(ofSize: 22)
        self.Status.textColor = .white
        self.WebGif.isHidden = false
    }}
}
