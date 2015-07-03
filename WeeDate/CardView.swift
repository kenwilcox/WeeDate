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
  
  var name: String? {
    didSet {
      if let name = name {
        nameLabel.text = name
      }
    }
  }
  
  var image: UIImage? {
    didSet {
      if let image = image {
        imageView.image = image
      }
    }
  }
  
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
    self.imageView.backgroundColor = UIColor.clearColor()
    addSubview(imageView)
    
    // manually setting up constraints
    self.nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    // bitmatch blue color
    self.nameLabel.backgroundColor = UIColor(red: 0.29, green: 0.56, blue: 0.89, alpha: 1.0)
    // salmon like
    //self.nameLabel.backgroundColor = UIColor(red: 0.96, green: 0.80, blue: 0.80, alpha: 0.70)
    self.nameLabel.textColor = UIColor.whiteColor()
    self.nameLabel.textAlignment = NSTextAlignment.Center
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
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: -40))
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 10))
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -10))
    addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: -10))
  }
}
