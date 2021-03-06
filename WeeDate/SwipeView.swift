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
        insertSubview(v, belowSubview: overlay)
        v.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
      }
    }
  }
  
  private var originalPoint: CGPoint?
  weak var delegate: SwipeViewDelegate?
  let overlay: UIImageView = UIImageView()
  var direction: Direction?
  var yeahImage = UIImage(named: "yeah-stamp")
  var nahImage = UIImage(named: "nah-stamp")
  
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
    self.backgroundColor = UIColor.clearColor()
    self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
    self.overlay.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    self.addSubview(overlay)
  }
  
//  func rotateByDegrees(rotationAngle: CGFloat) {
//    transform = CGAffineTransformMakeRotation(rotationAngle)
//  }
  
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
      updateOverlay(distance.x)
      
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
    
    UIView.animateWithDuration(0.5, animations: {
      self.center.x = self.frame.origin.x + parentWidth
      self.updateOverlay(self.frame.origin.x + parentWidth)
      }, completion: {
        success in
        if let delegate = self.delegate {
          direction == .Right ? delegate.swipedRight(): delegate.swipedLeft()
        }
      })
  }
  
  private func updateOverlay(distance: CGFloat) {
    var newDirection: Direction = distance < 0 ? .Left: .Right
    
    if newDirection != direction {
      direction = newDirection
      overlay.image = direction == .Right ? yeahImage : nahImage
    }
    overlay.alpha = abs(distance) / (superview!.frame.width/2)
  }
  
  private func resetViewPositionAndTransformations() {
    UIView.animateWithDuration(0.2, animations: { () -> Void in
      self.center = self.originalPoint!
      self.transform = CGAffineTransformMakeRotation(0)
      self.overlay.alpha = 0
    })
  }
}

protocol SwipeViewDelegate: class {
  func swipedLeft()
  func swipedRight()
}
