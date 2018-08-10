//
//  SlideInPresentationManager.swift
//  MedalCount
//
//  Created by Bereket Ghebremedhin  on 8/8/18.
//  Copyright © 2018 Ron Kliffer. All rights reserved.
//

import UIKit
import Foundation

enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}


class SlideInPresentationManager: NSObject {
  var direction = PresentationDirection.left 
}

//responisible for laoding the UIPresentationController and the presentation/dismissal of animation controllers
//Always must conform to the UIViewControllerTransitionDelegate
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
//here we instantiate a SlideInPresentationController with a direction from a SlideInPresentationManager and return it to use for the presentation
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController)-> UIPresentationController? {
    let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
    return presentationController
  }
  //NOTE: the two functions below both return a SlideInPresentationAnimator, just with different isPresentation values.
  //returns the animation controller for the presenting viewController
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideInPresentationAnimator(direction: direction, isPresentation: true)
  }
  //returns animation for dimissed viewController
  func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      return SlideInPresentationAnimator(direction: direction, isPresentation: false)
  }
  
}
