//
//  ViewController.swift
//  Canvas
//
//  Created by Chris Q. on 10/22/18.
//  Copyright © 2018 Chris Q. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var theArrowImage: UIImageView!
    
    var trayOriginalCenter: CGPoint!
    var trayDown: CGPoint!
    var trayUp: CGPoint!
    
    var newFace: UIImageView!
    var newFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayOriginalCenter = trayView.center
        let trayDownOffset = 205.0
        
        trayDown = CGPoint(x: Double(trayView.center.x) ,y: Double(trayView.center.y) + trayDownOffset)
        trayUp = trayView.center
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func pannedTray(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if(sender.state == .began){
            //print(translation)
            trayOriginalCenter = trayView.center
        }
        if(sender.state == .changed){
            //print(translation)
            let y = translation.y
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + y)
        }
        if(sender.state == .ended){
            //print(translation)
            if(velocity.y > 0){
                print("going down")
                UIView.animate(withDuration: 1, animations: {
                    self.trayView.center = self.trayDown
                }, completion: nil)
                theArrowImage.image = UIImage(named: "up_arrow")
            }
            else{
                print("going up")
                UIView.animate(withDuration: 1, animations: {
                    self.trayView.center = self.trayUp
                }, completion: nil)
                theArrowImage.image = UIImage(named: "down_arrow")
            }
        }
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        
        if(sender.state == .began){
            newFace = sender.view as! UIImageView
            newFaceOriginalCenter = newFace.center
        }
        if(sender.state == .changed){
            newFace.center = CGPoint(x: newFaceOriginalCenter.x + translation.x, y: newFaceOriginalCenter.y + translation.y)
        }
        if(sender.state == .ended){
            print("done placing old face")
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let imageView = sender.view as! UIImageView
        let translation = sender.translation(in: view)
        
        if(sender.state == .began){
            newFace = UIImageView(image: imageView.image)
            newFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            newFace.addGestureRecognizer(panGestureRecognizer)
            view.addSubview(newFace)
            newFace.center = imageView.center
            newFace.center.y += trayView.frame.origin.y
            newFaceOriginalCenter = newFace.center
        }
        if(sender.state == .changed){
            
            newFace.center = CGPoint(x: newFaceOriginalCenter.x + translation.x, y: newFaceOriginalCenter.y + translation.y)
 
        }
        if(sender.state == .ended){
            print("done placing new face")
        }
    }
    
    
}

