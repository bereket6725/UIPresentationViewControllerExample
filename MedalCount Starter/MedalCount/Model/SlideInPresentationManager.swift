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
  func presentController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController)-> UIPresentationController {
    let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
    return presentationController
  }
  
}
