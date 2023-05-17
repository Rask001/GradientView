/*
 GradientView, нужен для добавления градиента на вью.
 Имеется 2 публичных метода:
 applyGradient - метод добавляет градиент на указанную в параметр view.
 getGradientLayer - метод возвращает градиент слой 'CAGradientLayer' c установленными параметрами.
 
 Created by Антон Прокопьев on 20.12.2022.
 */

import UIKit

//MARK: - GradientView
open class GradientView: UIView {
    
    //MARK: - Property
    private let gradientLayer = CAGradientLayer()
    
    //MARK: - Init
    private init(from: Point, to: Point, startColor: UIColor, endColor: UIColor) {
        self.init()
        setupGradient(from: from, to: to, startColor: startColor, endColor: endColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - Public methods
extension GradientView {
    ///метод добавляет градиент на layer, указанной View
    public func applyGradient(view: UIView, from: Point, to: Point, startColor: UIColor, endColor: UIColor) {
        view.backgroundColor = nil
        view.layoutIfNeeded()
        let gradientView = GradientView(from: from, to: to, startColor: startColor, endColor: endColor)
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = view.bounds
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    /// метод возвращает градиент.
    /// Не забыть указать - gradient.frame = view.bounds.
    /// Не забыть добавить: layer.addSublayer(grad).
    /// Использлвать в методах viewDidLayout || viewDidLayoutSubviews!
    public func getGradientLayer(from: Point, to: Point, startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = from.point
        gradientLayer.endPoint = to.point
        return gradientLayer
    }
}

//MARK: - Private methods
extension GradientView {
    private func setupGradient(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors(startColor: startColor, endColor: endColor)
        gradientLayer.startPoint = from.point
        gradientLayer.endPoint = to.point
    }
    
    private func setupGradientColors(startColor: UIColor?, endColor: UIColor?) {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}

//MARK: - Point Enum
extension GradientView {
    public enum Point {
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
}
