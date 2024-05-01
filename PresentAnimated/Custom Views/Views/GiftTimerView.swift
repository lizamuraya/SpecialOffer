import UIKit

final class GiftTimerView: UIView {
    
    var timer = Timer()
    var countdownLabel = UILabel()
    var giftImageView = UIImageView()
    var remainingTime: Int = 25 * 60 + 14
    
    let strokeTextAttributes: [NSAttributedString.Key : Any] = [
        .strokeColor : UIColor.black,
        .foregroundColor : UIColor.white,
        .strokeWidth : -2.0 ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .black.withAlphaComponent(0.6)
        
        let circleSize: CGFloat = min(frame.size.width, frame.size.height)
        
        giftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: circleSize * 0.7, height: circleSize * 0.7))
        giftImageView.image = UIImage(named: "gift")
        giftImageView.contentMode = .scaleAspectFit
        giftImageView.center = CGPoint(x: circleSize / 2, y: circleSize / 2 - 12)
        addSubview(giftImageView)
        
        countdownLabel = UILabel(frame: CGRect(x: 0, y: 0, width: giftImageView.frame.width * 0.7, height: 40))
        countdownLabel.center = CGPoint(x: circleSize / 2, y: circleSize / 2 + 25)
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = .white
        countdownLabel.adjustsFontSizeToFitWidth = true
        countdownLabel.minimumScaleFactor = 0.5
        countdownLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        addSubview(countdownLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }
    
    
    @objc func updateTimer() {
        remainingTime -= 1
        
        let hours = remainingTime / 3600
        let minutes = (remainingTime % 3600) / 60
        let seconds = remainingTime % 60
        
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        countdownLabel.attributedText = NSAttributedString(string: timeString, attributes: strokeTextAttributes)
        
        if remainingTime <= 0 {
            timer.invalidate()
        }
    }
    
    func startAnimation() {
        let rotateLeftAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateLeftAnimation.fromValue = 0
        rotateLeftAnimation.toValue = -CGFloat.pi / 12
        rotateLeftAnimation.duration = 0.2
        rotateLeftAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let rotateRightAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateRightAnimation.fromValue = -CGFloat.pi / 12
        rotateRightAnimation.toValue = 0
        rotateRightAnimation.duration = 0.2
        rotateRightAnimation.beginTime = rotateLeftAnimation.duration
        rotateRightAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotateLeftAnimation, rotateRightAnimation]
        groupAnimation.duration = 0.4
        groupAnimation.repeatCount = 3
        
        giftImageView.layer.add(groupAnimation, forKey: "rotateAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + groupAnimation.duration * 3) {
            self.giftImageView.layer.removeAllAnimations()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.startAnimation()
            }
        }
    }
}
