//
//  UIView+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import UIKit

extension UIView {
    /**
     여러 개의 뷰를 현재 뷰에 추가합니다.
     
     - Parameter views: 추가할 뷰들의 배열.
     Tag: #addsubView
     */
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}

extension UIView {
    /**
     현재 뷰에 회색 그라디언트 효과를 적용합니다.
     
     하얀배경에서 회색 그라데이션으로 아이콘이 잘보이도록 만들떄 사용
     Tag: #그라디언트, #gradiendt
     */
    func greyGradiendt() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        let color = [UIColor.black.withAlphaComponent(0.3).cgColor,
                     UIColor.clear.cgColor]
        gradientLayer.colors = color
        self.layer.sublayers?.removeAll()
        self.backgroundColor = .clear
        self.layer.addSublayer(gradientLayer)
    }
    
    /**
     수직 그라디언트 레이어를 추가하여 현재 뷰에 적용합니다.
     - Parameters:
     - topColor: 그라디언트의 상단 색상.
     - bottomColor: 그라디언트의 하단 색상.
     - startPoint: 그라디언트의 시작 지점. 기본값은 (0, 0)입니다.
     - endPoint: 그라디언트의 종료 지점. 기본값은 (0, 1)입니다.
     Tag: #그라디언트, #gradiendt
     */
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor,
                                  startPoint: CGPoint = .zero,
                                  endPoint: CGPoint = CGPoint(x: 0, y: 1)) {
        let address = "\(Unmanaged.passUnretained(self).toOpaque())"
        let sublayers = self.layer.sublayers ?? []
        if let addedLayerIndex = sublayers.firstIndex(where: { $0.name == address }) {
            let addedLayer = sublayers[addedLayerIndex]
            addedLayer.frame = self.bounds
            return
        }
        let gradient = CAGradientLayer()
        gradient.name = address
        gradient.frame = self.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.backgroundColor = .clear
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    /**
     수직 그라디언트 레이어를 추가하여 현재 뷰에 적용합니다.
     
     - Parameters:
     - topColor: 그라디언트의 상단 색상.
     - bottomColor: 그라디언트의 하단 색상.
     - location: 그라디언트의 위치 배열. 0.0과 1.0 사이의 값을 가지며, 각 색상의 위치를 지정합니다.
     Tag: #그라디언트, #gradiendt
     */
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor,
                                  location: [NSNumber]) {
        let address = "\(Unmanaged.passUnretained(self).toOpaque())"
        let sublayers = self.layer.sublayers ?? []
        if let addedLayerIndex = sublayers.firstIndex(where: { $0.name == address }) {
            let addedLayer = sublayers[addedLayerIndex]
            addedLayer.frame = self.bounds
            return
        }
        let gradient = CAGradientLayer()
        gradient.name = address
        gradient.frame = self.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = location
        self.backgroundColor = .clear
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    ///버그가 있어서 사용을 권장하지 않음
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // 22.12.07 windy dot line color
    /**
     점선으로 된 검은색 테두리를 추가합니다.
     Tag: #border, #DashLine
     */
    func addDashedBlackBorder() {
        layer.sublayers?.removeAll()
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.label.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [1,2]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addDashedBorder() {
        let color = UIColor.gray
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    /**
     360도 회전 애니메이션을 적용합니다.
     
     - Parameters:
     - duration: 애니메이션의 지속 시간 (기본값: 1초)
     
     - Note: 이 메서드를 호출하기 전에 `self`의 `layer`가 설정되어 있어야 합니다.
     Tag: #Animation, #360
     */
    func rotate360(duration: CFTimeInterval = 1) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    /**
     선 모양의 점선 효과를 가진 테두리 레이어를 추가합니다.
     - Parameters:
     - pattern: 선의 패턴 배열. 값이 nil인 경우 실선으로 표시됩니다.
     - radius: 테두리의 모서리 반지름.
     - color: 선의 색상.
     
     - Returns: 추가된 테두리 레이어.
     */
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
    /// UiView에 DashLine을 추가해줍니다.
    ///
    ///  주의사항
    ///
    ///  Line을 그리려면 View의 영역이 정해진 이후여야 하기 때문에
    ///  완전히 그려진 이후인 layoutSubviews() 에서 호출 해야 합니다.
    ///
    ///  또는 override func viewDidLayoutSubviews() {}에서 호출 해야 합니다.
    ///  예시) DashLineView 검색 후 사용바랍니다.
    ///
    func addDashLineOnlyOne(color: UIColor = .gray) {
        let address = "\(Unmanaged.passUnretained(self).toOpaque())"
        let sublayers = self.layer.sublayers ?? []
        
        //MARK: -- 중복 Layer 방지
        if let addedLayerIndex = sublayers.firstIndex(where: { $0.name == address }) {
            let addedLayer = sublayers[addedLayerIndex]
            addedLayer.frame = self.bounds
            return
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = address
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [2, 2]
        
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
}

extension CALayer {
    /**
     Sketch 소프트웨어의 그림자 효과를 적용합니다.
     
     - Parameters:
     - color: 그림자의 색상.
     - alpha: 그림자의 투명도.
     - x: 그림자의 X축 오프셋.
     - y: 그림자의 Y축 오프셋.
     - blur: 그림자의 흐림 정도.
     - spread: 그림자의 확장 정도.
     */
    func applySketchShadow(color: UIColor, alpha: Float,
                           x: CGFloat, y: CGFloat,
                           blur: CGFloat, spread: CGFloat) {
        let address = "\(Unmanaged.passUnretained(self).toOpaque())"
        let sublayers = self.sublayers ?? []
        
        //MARK: -- 중복 Layer 방지
        if let addedLayerIndex = sublayers.firstIndex(where: { $0.name == address }) {
            let addedLayer = sublayers[addedLayerIndex]
            addedLayer.frame = self.bounds
            return
        }
        
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / UIScreen.main.scale
        if spread == 0 {
            shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

