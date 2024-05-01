import UIKit

final class RoundedLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        super.drawText(in: rect.inset(by: insets))
    }
}
