//Universal file for create GradientLayer



import UIKit

class GradientView: UIView {
	
	private let gradientLayer = CAGradientLayer()
	
	enum Point {
		case topLeading
		case leading
		case bottomLeading
		case top
		case center
		case bottom
		case topTrailing
		case trailing
		case bottomTrailing
		
		var point: CGPoint {
			switch self {
			case .topLeading:
				return CGPoint(x: 0, y: 0)
			case .leading:
				return CGPoint(x: 0, y: 0.5)
			case .bottomLeading:
				return CGPoint(x: 0, y: 1)
			case .top:
				return CGPoint(x: 0.5, y: 0)
			case .center:
				return CGPoint(x: 0.5, y: 0.5)
			case .bottom:
				return CGPoint(x: 0.5, y: 1)
			case .topTrailing:
				return CGPoint(x: 1, y: 0)
			case .trailing:
				return CGPoint(x: 1, y: 0.5)
			case .bottomTrailing:
				return CGPoint(x: 1, y: 1)
			}
		}
	}
	
	init(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
		self.init()
		setupGradient(from: from, to: to, startColor: startColor, endColor: endColor)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}
	
	private func setupGradient(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
		self.layer.addSublayer(gradientLayer)
		setupGradientColors(startColor: startColor, endColor: endColor)
		gradientLayer.startPoint = from.point
		gradientLayer.endPoint = to.point
	}
	
	private func setupGradientColors(startColor: UIColor?, endColor: UIColor?) {
		if let startColor = startColor, let endColor = endColor {
			gradientLayer.colors = [startColor.cgColor, endColor.cgColor ]
		}
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}



extension UIView {
	func applyGradients(cornerRadius: CGFloat) {
		self.backgroundColor = nil
		self.layoutIfNeeded()
		let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1), endColor: #colorLiteral(red: 0.4032760262, green: 0.7716199756, blue: 1, alpha: 1))
		if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
			gradientLayer.frame = self.bounds
			gradientLayer.cornerRadius = cornerRadius
		self.layer.insertSublayer(gradientLayer, at: 0)
		}
	}
}
