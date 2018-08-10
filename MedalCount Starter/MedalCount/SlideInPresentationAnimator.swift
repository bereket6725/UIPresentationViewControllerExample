//
//  SlideInPresentationAnimator.swift
//  MedalCount
//
//  Created by Bereket Ghebremedhin  on 8/9/18.
//  Copyright © 2018 Ron Kliffer. All rights reserved.
//

import UIKit
//for complex animations that are significantly different from dismissal, you create 2 controllers:
//1 for presentation and 1 for dismissal.
//We implement this in an NSObject sublcass that conforms to: UIViewControllerAnimatedTransitioning
final class SlideInPresentationAnimator: NSObject {
  //lets the animation controller know which direction we should animate the viewControllers view
  let direction: PresentationDirection
  //this bool tells the animation controller whether to present or dismiss the viewController
  let isPresentation: Bool
  //intializes our properties
  init(direction: PresentationDirection, isPresentation: Bool){
    self.direction = direction
    self.isPresentation = isPresentation
    super.init()
  }
}
