//
//  FirstViewController.swift
//  OverlayOptions
//
//  Created by Thaihoa on 9/24/15.
//  Copyright © 2015 Thaihoa. All rights reserved.
//

import UIKit



class FirstViewController: UIViewController {

    var overlayMenu: HTOverlayView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttons = [HTOverlayViewButton]()
        buttons.append(HTOverlayViewButton(id: "b1", text: "New", image: UIImage(named: "facebook_filled-32")))
        buttons.append(HTOverlayViewButton(id: "b2", text: "Share", image: UIImage(named: "twitter_filled-32")))
        buttons.append(HTOverlayViewButton(id: "b3", text: "Option", image: UIImage(named: "keyboard")))
        
        overlayMenu = HTOverlayWithButtonsView(_controller: (self.navigationController?.tabBarController!)!, buttons: buttons)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onAdd(sender: AnyObject) {
        self.overlayMenu?.show()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

}

