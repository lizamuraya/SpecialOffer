import UIKit
import CHTCollectionViewWaterfallLayout

final class MainVC: UIViewController {
    
    let bannerView = BannerView()
    let labelHashtags = UILabel()
    let hashtagScrollView = UIScrollView()
    private let collectionView: UICollectionView = makeCollectionView()
    let giftTimerView = GiftTimerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    private var models: [Waterfall] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViews()
        setupConstraints()
        addHashtags()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           giftTimerView.startAnimation()
       }
    
    private func setupViews() {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        labelHashtags.translatesAutoresizingMaskIntoConstraints = false
        labelHashtags.text = Text.suitsFor
        labelHashtags.textColor = .white
        labelHashtags.font = .systemFont(ofSize: 16)
        view.addSubview(labelHashtags)
        
        hashtagScrollView.translatesAutoresizingMaskIntoConstraints = false
        hashtagScrollView.backgroundColor = .clear
        hashtagScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(hashtagScrollView)
        
        giftTimerView.translatesAutoresizingMaskIntoConstraints = false
        giftTimerView.layer.cornerRadius = 50
        view.addSubview(giftTimerView)
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: guide.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 108),
            
            labelHashtags.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 20),
            labelHashtags.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            labelHashtags.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            
            hashtagScrollView.topAnchor.constraint(equalTo: labelHashtags.bottomAnchor, constant: 8),
            hashtagScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            hashtagScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            hashtagScrollView.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: hashtagScrollView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            giftTimerView.widthAnchor.constraint(equalToConstant: 100),
            giftTimerView.heightAnchor.constraint(equalToConstant: 100),
            giftTimerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -5),
            giftTimerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20)
        ])
    }
    
    private func addHashtags() {
        let hashtagLabels = ["#Осень", "#Портрет", "#Insta-стиль", "#Люди", "#Природа"]
        let hashtagHeight: CGFloat = 30
        
        var xOffset: CGFloat = 0
        let padding: CGFloat = 8
        
        for hashtag in hashtagLabels {
            let hashtagLabel = RoundedLabel()
            hashtagLabel.text = hashtag
            hashtagLabel.textColor = .blueAccent
            hashtagLabel.font = .systemFont(ofSize: 15, weight: .semibold)
            hashtagLabel.sizeToFit()
            hashtagLabel.frame.origin = CGPoint(x: xOffset, y: 0)
            hashtagLabel.frame.size.width += 2 * padding
            hashtagLabel.frame.size.height = hashtagHeight
            hashtagLabel.layer.cornerRadius = hashtagHeight / 2
            hashtagLabel.layer.masksToBounds = true
            hashtagLabel.backgroundColor = .blueAccent.withAlphaComponent(0.15)
            hashtagScrollView.addSubview(hashtagLabel)
            xOffset += hashtagLabel.frame.width + 10
        }
        hashtagScrollView.contentSize = CGSize(width: xOffset, height: hashtagHeight)
    }
    
    private func setupCollectionView() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        let images = Array(1...6).map { "image\($0)" }
        models = images.compactMap {
            return Waterfall(imageName: $0, height: CGFloat.random(in: 200...400))}
    }
    
    private static func makeCollectionView() -> UICollectionView {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2, height: models[indexPath.row].height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(image: UIImage(named: models[indexPath.row].imageName))
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

private enum Text {
    static let suitsFor =  "Подходит для:"
}
