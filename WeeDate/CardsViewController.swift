//
//  CardsViewController.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/5/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import Parse

class CardsViewController: UIViewController {
  
  struct Card {
    let cardView: CardView
    let swipeView: SwipeView
  }
  
  let frontCardTopMargin: CGFloat = 0.0
  let backCardTopMargin: CGFloat = 10.0

  @IBOutlet weak var cardStackView: UIView!
  
  var backCard: Card?
  var frontCard: Card?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    cardStackView.backgroundColor = UIColor.clearColor()
    
    backCard = createCard(backCardTopMargin)
    cardStackView.addSubview(backCard!.swipeView)
    
    frontCard = createCard(frontCardTopMargin)
    cardStackView.addSubview(frontCard!.swipeView)
    
    let testObject = PFObject(className: "TestObject")
    testObject["foo"] = "bar"
    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      println("Object has been saved.")
    }

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: - Helper functions
  private func createCardFrame(topMargin: CGFloat)->CGRect {
    return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
  }
  
  private func createCard(topMargin: CGFloat) -> Card {
    let cardView = CardView()
    let swipeView = SwipeView(frame: createCardFrame(topMargin))
    swipeView.delegate = self
    swipeView.innerView = cardView
    return Card(cardView: cardView, swipeView: swipeView)
  }
}

//MARK: - SwipeViewDelegate
extension CardsViewController: SwipeViewDelegate {
  func swipedLeft() {
    println("left")
    if let frontCard = self.frontCard {
      frontCard.swipeView.removeFromSuperview()
    }
  }
  
  func swipedRight() {
    println("right")
    if let frontCard = self.frontCard {
      frontCard.swipeView.removeFromSuperview()
    }
  }
}
