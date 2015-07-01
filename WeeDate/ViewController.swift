//
//  ViewController.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/2/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

// The options are just to remind me that they are there
let pageController = ViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey:-0.05])

class ViewController: UIPageViewController {
  
  let cardsVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as! UIViewController
  let profileVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileNavController") as! UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    view.backgroundColor = UIColor.whiteColor()
    dataSource = self
    
    self.setViewControllers([cardsVC], direction: .Forward, animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func goToNextVC() {
    let nextVC = pageViewController(self, viewControllerAfterViewController: viewControllers[0] as! UIViewController)!
    setViewControllers([nextVC], direction: .Forward, animated: true, completion: nil)
  }
  
  func goToPreviousVC() {
    let previousVC = pageViewController(self, viewControllerBeforeViewController: viewControllers[0] as! UIViewController)!
    setViewControllers([previousVC], direction: .Reverse, animated: true, completion: nil)
  }
}

// MARK: - UIPageViewControllerDataSource
extension ViewController: UIPageViewControllerDataSource {
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
    switch viewController {
    case cardsVC:
      return profileVC
    default:
      return nil
    }
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    switch viewController {
    case profileVC:
      return cardsVC
    default:
      return nil
    }
  }
}