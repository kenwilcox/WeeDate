//
//  ViewController.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/2/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.view.addSubview(CardView(frame: CGRect(x: 80.0, y: 80.0, width: 120.0, height: 200.0)))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

