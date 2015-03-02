//
//  CanvasViewController.swift
//  Exercise4
//
//  Created by John Boggs on 2/25/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var treyView: UIView!
    var originalCenter : CGPoint!
    var topCenter: CGPoint!
    var bottomCenter: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topCenter = CGPoint(x: 187.5, y: 576.5)
        bottomCenter = CGPoint(x: 187.5, y: 840)
        
//        bottomCenter.y =
        
        // Do any additional setup after loading the view.
    }

    @IBAction func smileyPan(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            let imageView = sender.view as UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            self.view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += treyView.frame.origin.y
        } else if sender.state == UIGestureRecognizerState.Ended{
            
        } else {

        }
    }
    
    @IBAction func pan(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            self.originalCenter = self.treyView.center
        } else if sender.state == UIGestureRecognizerState.Ended{
            var velocity = sender.velocityInView(treyView)
            if velocity.y > 0 {
                UIView.animateWithDuration(0.5, animations: {
                    self.treyView.center = self.bottomCenter
                })
            } else {
                UIView.animateWithDuration(0.5, animations: {
                    self.treyView.center = self.topCenter
                })
            }
        } else {
            let translation = sender.translationInView(self.treyView)
            treyView.center = CGPoint(x: originalCenter.x, y: originalCenter.y + translation.y)
            println(treyView.center)
        }
    }
}
