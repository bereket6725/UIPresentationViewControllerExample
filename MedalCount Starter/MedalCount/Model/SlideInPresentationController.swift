//
//  SlideInPresentationController.swift
//  MedalCount
//
//  Created by Bereket Ghebremedhin  on 8/8/18.
//  Copyright © 2018 Ron Kliffer. All rights reserved.
//

import UIKit
import Foundation


class SlideInPresentationController: UIPresentationController {
  //1.
  // MARK: - Properties
  //Represents to direction of presention
  private var direction: PresentationDirection
  fileprivate var dimmingView: UIView!
  //OPTIONAL DELEGATE METHOD
  override func presentationTransitionWillBegin() {
    //UIPresentationController has a property called "containerView"
    //It holds the view hierarchy of the presentation and presented viewControllers
    //the line below inserts our dimmingView to the back of the hierarchy
    containerView?.insertSubview(dimmingView, at: 0)
    //below, we constrain the dimmingView to the edges of the containerView so it fills the entire screen
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V: |[dimmingView]", options: [], metrics: nil, views: ["dimmingView":dimmingView]))
    NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H: |[dimmingView]", options: [], metrics: nil, views: ["dimmingView":dimmingView]))
    //create our transtionCoordinator to handle the transition
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 1.0
      return
    }
    //method that allows us to set the dimming Views alpha to 1.0 while we transtion
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 1.0
    })
  }
  //OPTIONAL DELEGATE METHOD
  //setting the dimming view's alpha to 0 gives the appearance of it fading as it is dismissed
  override func dismissalTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 0.0
      return
    }
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
    })
  }
  //OPTIONAL DELEGATE METHOD
  //we reset the frame of the presentedView to fit any changes in the container view's frame
  override func containerViewWillLayoutSubviews() {
    presentedView?.frame = frameOfPresentedViewInContainerView
  }
  
  //this gives the presented viewControllers content to the presentation Ccntroller
  //method recieves: 1. content container and 2. the parents view size. Then uses the two
  //to calculate the size of the presented content
  //In this case we make the presented view 2/3rds the size of the screen by returning
  //(2.0/3.0) for the width of the horizontal and (2.0/3.0) the height for the vertical presentations
  override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    switch direction {
    case .left, .right:
      return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
    case .bottom, .top:
      return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
    }
  }
  
//2.
//takes in the "presented" and the "presenting view" viewController, including the presentation direction
  init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection) {
    self.direction = direction
//3.
//Calls the designated initializer for UIPresentationController and passes it the presented and presenting viewControllers
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    setUpDimmingView()
  }
}
// MARK: - Private
//sets up our dimmingView
//NOTE: We did not add it to a superView yet, that will happen when the presentation transition starts
private extension SlideInPresentationController {
  func setUpDimmingView(){
    dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    dimmingView.alpha = 0.0
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
    dimmingView.addGestureRecognizer(recognizer)
  }

  dynamic func handleTap(recognizer: UITapGestureRecognizer){
      presentingViewController.dismiss(animated: true, completion: nil)
  }
}
