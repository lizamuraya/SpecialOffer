import UIKit

final class GiftTimerVC: UIViewController {
    
    var giftTimerView = GiftTimerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        giftTimerView = GiftTimerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        giftTimerView.translatesAutoresizingMaskIntoConstraints = false
        giftTimerView.layer.cornerRadius = 50
        giftTimerView.center = self.view.center
        view.addSubview(giftTimerView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        giftTimerView.startAnimation()
    }
}
