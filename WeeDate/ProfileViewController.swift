//
//  ProfileViewController.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/26/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    nameLabel.text = currentUser()?.name
    currentUser()?.getPhoto({
      image in
      self.imageView.layer.masksToBounds = true
      self.imageView.contentMode = .ScaleAspectFill
      self.imageView.image = image
      }
    )
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}