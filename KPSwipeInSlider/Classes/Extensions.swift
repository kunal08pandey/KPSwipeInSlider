//
//  Extensions.swift
//  KPSwipeInSlider
//
//  Created by Kunal Pandey on 17/01/20.
//

import Foundation

enum Direction {
  case top
  case left
  case bottom
  case right
}

extension UIView {
  
  var x: CGFloat {
    set {
      frame.origin.x = newValue
    }
    get  {
      return frame.origin.x
    }
  }
  
  var y: CGFloat {
    set {
      frame.origin.y = newValue
    }
    get  {
      return frame.origin.y
    }
  }
  
  var width: CGFloat {
    set {
      frame.size.width = newValue
    }
    get  {
      return frame.size.width
    }
  }
  
  var height: CGFloat {
    set {
      frame.size.height = newValue
    }
    get  {
      return frame.size.height
    }
  }
  
}

extension UIBezierPath {
  
  func drawLine(source: CGPoint, destination: CGPoint) {
    move(to: source)
    addLine(to: destination)
  }
  
  func drawArrow(center: CGPoint, width: CGFloat, color: UIColor, direction: Direction) {
    let difference = CGFloat(5.0)
    var x = center.x
    var y = center.y
    x = getArrowFirstX(center, direction, difference)
    y = getArrowFirstY(center, direction, difference)
    let firstDestinationPoint = CGPoint(x: x, y: y)
    drawLine(source: center, destination: firstDestinationPoint)
    x = getArrowSecondX(center, direction, difference)
    y = getArrowSecondY(center, direction, difference)
    let secondDestinationPoint = CGPoint(x: x, y: y)
    drawLine(source: center, destination: secondDestinationPoint)
    print("Center: \(center), left: \(firstDestinationPoint), right: \(secondDestinationPoint)")
    UIColor.white.setStroke()
    lineCapStyle = .round
    lineWidth = width
    stroke()
  }
  
  func getArrowFirstX(_ point: CGPoint, _ direction: Direction, _ difference: CGFloat) -> CGFloat {
    switch direction {
    case .left:
      return point.x + 2 * difference
    case .right:
      return point.x - 2 * difference
    case .top:
      return point.x + difference
    case .bottom:
      return point.x - difference
    }
  }
  
  func getArrowSecondX(_ point: CGPoint, _ direction: Direction, _ difference: CGFloat) -> CGFloat {
    switch direction {
    case .left:
      return point.x - 2 * difference
    case .right:
      return point.x + 2 * difference
    case .top:
      return point.x - difference
    case .bottom:
      return point.x + difference
    }
  }
  
  func getArrowFirstY(_ point: CGPoint, _ direction: Direction, _ difference: CGFloat) -> CGFloat {
    switch direction {
    case .left:
      return point.y - difference
    case .right:
      return point.y + difference
    case .top:
      return point.y - 2 * difference
    case .bottom:
      return point.y + 2 * difference
    }
  }
  
  func getArrowSecondY(_ point: CGPoint, _ direction: Direction, _ difference: CGFloat) -> CGFloat {
    switch direction {
    case .left:
      return point.y + difference
    case .right:
      return point.y - difference
    case .top:
      return point.y + 2 * difference
    case .bottom:
      return point.y - 2 * difference
    }
  }
}
