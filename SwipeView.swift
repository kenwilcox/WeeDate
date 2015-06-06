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
  private let card: CardView = CardView()
  private var originalPoint: CGPoint?
  
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
    addSubview(card)
    
    self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
    
    card.setTranslatesAutoresizingMaskIntoConstraints(false)
    setConstraints()
  }
  
  func dragged(gestureRecognizer: UIPanGestureRecognizer) {
    let distance = gestureRecognizer.translationInView(self)
    println("Distance x:\(distance.x) y: \(distance.y)")
    
    switch gestureRecognizer.state {
    case UIGestureRecognizerState.Began:
      originalPoint = center
    case UIGestureRecognizerState.Changed:
      center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
    case UIGestureRecognizerState.Ended:
      resetViewPositionAndTransformations()
    default:
      println("Default trigged for GestureRecognizer: \(gestureRecognizer.state)")
      break
    }
  }
  
  private func resetViewPositionAndTransformations() {
    UIView.animateWithDuration(0.2, animations: { () -> Void in
      self.center = self.originalPoint!
    })
  }
  
  private func setConstraints() {
    // Card View
    addConstraint(NSLayoutConstraint(item: card, attribute: .Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: card, attribute: .Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: card, attribute: .Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: card, attribute: .Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0))
  }
}