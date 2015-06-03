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
    layer.borderColor = UIColor.lightGrayColor().CGColor
    layer.cornerRadius = 5
    layer.masksToBounds = true
  }
}
