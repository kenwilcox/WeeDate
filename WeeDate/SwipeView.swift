//
//  SwipeView.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/5/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation
import UIKit

class SwipeView: UIView {
  
  enum Direction {
    case None
    case Left
    case Right
  }
  
  var innerView: UIView? {
    didSet {
      if let v = innerView {
        addSubview(v)
        v.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
      }
    }
  }
  
  private var originalPoint: CGPoint?
  weak var delegate: SwipeViewDelegate?
  
  //MARK: - Initializers
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  init() {
    super.init(frame: CGRectZero)
    initialize()
  }
  
  //MARK: - Helper functions
  private func initialize() {
    //TODO: set back to clearColor when we have images
    self.backgroundColor = UIColor.redColor()    
    self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
  }
  
  func dragged(gestureRecognizer: UIPanGestureRecognizer) {
    let distance = gestureRecognizer.translationInView(self)
    println("Distance x:\(distance.x) y: \(distance.y)")
    
    switch gestureRecognizer.state {
    case UIGestureRecognizerState.Began:
      originalPoint = center
      
    case UIGestureRecognizerState.Changed:
//      let rotationPercent = min(distance.x/(self.superview!.frame.width/2), 1)
      let rotationPercent = distance.x/(self.superview!.frame.width/2)
      let rotationAngle = (CGFloat(2*M_PI/16)*rotationPercent)
      transform = CGAffineTransformMakeRotation(rotationAngle)
      center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
      
    case UIGestureRecognizerState.Ended:
      if abs(distance.x) < frame.width/4 {
        resetViewPositionAndTransformations()
      } else {
        swipe(distance.x > 0 ? .Right : .Left)
      }
    
    default:
      println("Default trigged for GestureRecognizer: \(gestureRecognizer.state)")
      break
    }
  }
  
  func swipe(direction: Direction) {
    
    if direction == .None {
      return
    }
    
    var parentWidth = superview!.frame.size.width
    
    if direction == .Left {
      parentWidth *= -1
    }
    
    UIView.animateWithDuration(0.2, animations: {
      self.center.x = self.frame.origin.x + parentWidth
      }, completion: {
        success in
        if let delegate = self.delegate {
          direction == .Right ? delegate.swipedRight(): delegate.swipedLeft()
        }
      })
  }
  
  private func resetViewPositionAndTransformations() {
    UIView.animateWithDuration(0.2, animations: { () -> Void in
      self.center = self.originalPoint!
      self.transform = CGAffineTransformMakeRotation(0)
    })
  }
}

protocol SwipeViewDelegate: class {
  func swipedLeft()
  func swipedRight()
}
