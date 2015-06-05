//
//  CardView.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/2/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {
  private let imageView: UIImageView = UIImageView()
  private let nameLabel: UILabel = UILabel()
  
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
    // manually setting up constraints
    self.imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.imageView.backgroundColor = UIColor.redColor()
    addSubview(imageView)
    
    // manually setting up constraints
    self.nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(nameLabel)
    
    backgroundColor = UIColor.whiteColor()
    layer.borderWidth = 0.5
    layer.borderColor = UIColor.darkGrayColor().CGColor
    layer.cornerRadius = 5
    layer.masksToBounds = true
    
    setConstraints()
  }
  
  private func setConstraints() {
    // Image View
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0))
    
    // Label
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: .Bottom, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 10))
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -10))
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
  }
}
