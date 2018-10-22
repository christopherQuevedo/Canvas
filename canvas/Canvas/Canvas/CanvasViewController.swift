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
            //trayOriginalCenter = trayView.center
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
                /*
                UIView.animate(withDuration: 1, animations: {
                    self.trayView.center = self.trayDown
                    }}, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
 */
                trayView.center = trayDown
                theArrowImage.image = UIImage(named: "up_arrow")
            }
            else{
                print("going up")
                trayView.center = trayOriginalCenter
                theArrowImage.image = UIImage(named: "down_arrow")
            }
        }
    }
    
}

