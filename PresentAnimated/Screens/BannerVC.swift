import UIKit

final class BannerVC: UIViewController {
    
    var bannerView = BannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBannerView()
    }
    
    private func setupBannerView() {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: guide.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 108)
        ])
    }
}
