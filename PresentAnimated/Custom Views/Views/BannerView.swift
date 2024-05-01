import UIKit

final class BannerView: UIView {
    
    let leftLabel = UILabel()
    let additionalLabel = UILabel()
    let collageImageView = UIImageView()
    let paragraphStyle = NSMutableParagraphStyle()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?
            .compactMap { $0 as? CAGradientLayer }
            .first?
            .frame = bounds
        applyGradient(isVertical: false, colorArray: [.violetCustom, .pinkCustom])
    }
    
    private func setupViews() {
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        leftLabel.text = Text.tryFreeTrial
        leftLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        leftLabel.textColor = .white
        leftLabel.numberOfLines = 0
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        additionalLabel.text = Text.offerPremium
        additionalLabel.font = .systemFont(ofSize: 13, weight: .light)
        additionalLabel.textColor = .white.withAlphaComponent(0.7)
        additionalLabel.numberOfLines = 2
        additionalLabel.attributedText = NSAttributedString(string: additionalLabel.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        paragraphStyle.lineSpacing = 3
        
        collageImageView.image = UIImage(named: "collage")
        collageImageView.contentMode = .scaleAspectFit
        collageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(leftLabel, additionalLabel, collageImageView)
    }
    
    private func setupConstraints() {
        
        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            leftLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            leftLabel.trailingAnchor.constraint(equalTo: collageImageView.leadingAnchor, constant: -padding),
            
            additionalLabel.leadingAnchor.constraint(equalTo: leftLabel.leadingAnchor),
            additionalLabel.topAnchor.constraint(equalTo: leftLabel.bottomAnchor, constant: 8),
            additionalLabel.trailingAnchor.constraint(equalTo: collageImageView.leadingAnchor, constant: -padding),
            
            collageImageView.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: padding),
            collageImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            collageImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            collageImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}

extension UIView {
    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.compactMap { $0 as? CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map { $0.cgColor }
        if isVertical {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        } else {
            gradientLayer.locations = [0.0, 0.7]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addSubviews(_ views: UIView...) {
           for view in views {
               addSubview(view)
           }
       }
}

private enum Text {
    static let tryFreeTrial = "Try three days free trial"
    static let offerPremium = "You will get all premium templates, additional stickers and no ads"
}
