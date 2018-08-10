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

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
  //defines length of transition
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)-> TimeInterval {
    return 0.3
  }
  //performs animations
  //defines how long the transition takes
  //1. if this is a presentation, the method asks the transitionContext for the viewController assoicated with the '.to' key (the viewController you are moving to). If its dismissal, it asks the transitionContext for the viewController associate with the .from  key (he viewController you are moving from)
  //2. if the action is a presentation, we add the view Controllers view to the view hierarchy; this part uses the transition context to get the container view
  //3. Calculate the frames you are animating 'from' and 'to'
  //   the first line in part 3 asks the transitionContext for the views frame when its presented. The rest calculates its frame when its dismissed. This section sets the frames origin so its just outside the visible area based on the frames direction
  //4. Determines the transitiona inital and final frames. When presenting the viewController it from the dimissed to the presented frames and vice-versa for when its dismissing
  //5. animates view from initial to final frame. Calls 'completeTransition(_:)' on transtion context to show its finished
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
    //1.
    let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
    let controller = transitionContext.viewController(forKey: key)!
    //2
    if isPresentation {
      transitionContext.containerView.addSubview(controller.view)
    }
    //3
    let presentedFrame = transitionContext.finalFrame(for: controller)
    var dismissedFrame = presentedFrame
    switch direction {
    case .left:
      dismissedFrame.origin.x = -presentedFrame.width
    case .right:
      dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
    case .top:
      dismissedFrame.origin.y = -presentedFrame.height
    case .bottom:
      dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
    }
    //4
    let initialFrame = isPresentation ? dismissedFrame : presentedFrame
    let finalFrame = isPresentation ? presentedFrame : dismissedFrame
    //5
    let animationDuration = transitionDuration(using: transitionContext)
    controller.view.frame = initialFrame
    UIView.animate(withDuration: animationDuration, animations: {
      controller.view.frame = finalFrame}) {finished in
        transitionContext.completeTransition(finished)
    }
  }
  
}
