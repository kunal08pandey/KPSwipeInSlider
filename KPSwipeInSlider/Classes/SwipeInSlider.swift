//
//  SwipeInSlider.swift
//  KPSwipeInSlider
//
//  Created by Kunal Pandey on 17/01/20.
//

import UIKit

open class SwipeInControlView: UIView {
  
  let bezierPath = UIBezierPath()
  
  enum Constant {
    static let bezierPath = UIBezierPath()
    static let twistedVerticalPadding: CGFloat = 10.0
    static let normalVerticalPadding: CGFloat = 5.0
    static let lineWidth: CGFloat = 5.0
    static let horizontalPadding: CGFloat = 15.0
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
  }
  
  var isArrowHidden: Bool = false
  
  var isTwisted: Bool = false { didSet { setNeedsDisplay()  } }
  
  var arrowControlPoint: CGPoint {
//    var x = CGFloat.zero// bounds.minX + ((!isTwisted) ? Constant.twistedVerticalPadding : Constant.normalVerticalPadding)
    switch direction {
    case .top:
      return CGPoint(x: center.x, y: bounds.maxY)
    case .left:
      return CGPoint(x: bounds.maxX, y: center.y)
    case .right:
      return CGPoint(x: bounds.minX, y: center.y)
    case .bottom:
      return CGPoint(x: center.x, y: bounds.midY)
    }
    
  }
  
  var direction: Direction = .left
  
  var translatedX = CGFloat.zero
  var translatedY = CGFloat.zero
  
  var isBoundEffect: Bool = false
  
  var controlValue: CGFloat {
    switch direction {
    case .top:
      return height - Constant.screenHeight
    case .left:
      return Constant.screenWidth - width
    case.right:
      return Constant.screenWidth - width
    case .bottom:
      return Constant.screenHeight - height
    }
  }
  
  fileprivate func drawArrow() {
    guard !isArrowHidden else { return }
    bezierPath.removeAllPoints()
    let point = arrowControlPoint
    
    var arrowDirection = direction
    switch direction {
    case .left:
      arrowDirection = .right
    case .right:
      arrowDirection = .left
    case .top:
      arrowDirection = .bottom
    case .bottom:
      arrowDirection = .top
    }
    print("Arrow Drawing")
    
    bezierPath.drawArrow(center: point, width: Constant.lineWidth, color: .white, direction: arrowDirection)
  }
  
  override open func draw(_ rect: CGRect) {
    super.draw(rect)
    backgroundColor = .clear
    drawArrow()
  }
  
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  }
  
  override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let superview = self.superview, let point = touches.first?.location(in: superview) else { return }
    calculateTranslation(point)
    isArrowTwisted()
    startTransform()
  }
  
  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    //    if (Constants.controlCenterHeight / 2) > abs(translatedY) {
    //      UIView.animate(withDuration: Constants.animationDuration, animations: { [unowned self] in
    //        self.controlCenterContainerView.transform = .identity
    //      }) { [unowned self] _ in
    //        self.controlCenter.isTwisted = false
    //      }
    //      return
    //    }
    //    UIView.animate(withDuration: Constants.animationDuration, animations: { [unowned self] in
    //      self.controlCenterContainerView.transform = CGAffineTransform(translationX: Constants.controlCenterHeight , y: CGFloat.zero)
    //    }) { [unowned self] _ in
    //      self.controlCenter.isTwisted = true
    //    }
  }
  
  func calculateTranslation(_ point: CGPoint) {
    switch direction {
    case .top:
      let translatedPointY = (controlValue - height + point.y)
      if translatedY != translatedPointY {
        translatedY = translatedPointY
      }
    case .left:
      let translatedPointX = (controlValue - width + point.x)
      if translatedX != translatedPointX {
        translatedX = translatedPointX
      }
    case .right:
      let translatedPointX = (point.x - controlValue)
      if translatedX != translatedPointX {
        translatedX = translatedPointX
      }
    case .bottom:
      let translatedPointY = (point.y - controlValue)
      if translatedY != translatedPointY {
        translatedY = translatedPointY
      }
    }
  }
  
  func isArrowTwisted() {
    if translatedY < CGFloat.zero { return }
    isTwisted = (translatedY >= 20)
    if translatedX < CGFloat.zero { return }
    isTwisted = (translatedX >= 20)
  }
  
  func startTransform() {
    switch direction {
    case .top:
      transform = CGAffineTransform(translationX: translatedX , y: translatedY)
    case .left:
      transform = CGAffineTransform(translationX: translatedX , y: translatedY)
    case .right:
      transform = CGAffineTransform(translationX: translatedX , y: translatedY)
    case .bottom:
      transform = CGAffineTransform(translationX: translatedX , y: translatedY)
    }
  }
}
