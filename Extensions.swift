//
//  Extensions.swift
//  KPSwipeInSlider
//
//  Created by Kunal Pandey on 17/01/20.
//

import Foundation

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
