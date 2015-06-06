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
  
  private func initialize() {
    self.backgroundColor = UIColor.clearColor()
    addSubview(card)
    setConstraints()
  }
  
  private func setConstraints() {
    
  }
}