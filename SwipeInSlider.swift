//
//  SwipeInSlider.swift
//  KPSwipeInSlider
//
//  Created by Kunal Pandey on 17/01/20.
//

import UIKit

class SwipeInControlView: UIView {
  
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
  
  enum Direction {
    case top
    case left
    case right
    case bottom
  }
  
  var isArrowHidden: Bool = false
  
  var isTwisted: Bool = false { didSet { setNeedsDisplay()  } }
  
  var arrowControlPoint: CGPoint {
    let x = bounds.minX + ((!isTwisted) ? Constant.twistedVerticalPadding : Constant.normalVerticalPadding)
    return CGPoint(x: x, y: center.y)
  }
  
  var direction: Direction = .top
  
  var translatedX = CGFloat.zero
  var translatedY = CGFloat.zero
  
  var isBoundEffect: Bool = false
  
  var controlValue: CGFloat {
    switch direction {
    case .top:
      return Constant.screenHeight - height
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
    bezierPath.move(to: point)
    bezierPath.addLine(to: CGPoint(x: bounds.minX + Constant.normalVerticalPadding , y: point.y - Constant.horizontalPadding))
    bezierPath.move(to: point)
    bezierPath.addLine(to: CGPoint(x: bounds.minX + Constant.normalVerticalPadding, y: point.y + Constant.horizontalPadding))
    UIColor.white.setStroke()
    bezierPath.lineCapStyle = .round
    bezierPath.lineWidth = Constant.lineWidth
    bezierPath.stroke()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    backgroundColor = .clear
    drawArrow()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let superview = self.superview, let point = touches.first?.location(in: superview) else { return }
    calculateTranslation(point)
    isArrowTwisted()
    startTransform()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
      let translatedPointY = (controlValue - point.y)
      if translatedY != translatedPointY {
        translatedY = translatedPointY
      }
    case .left:
      let translatedPointX = (controlValue - point.x)
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
