//
//  HTOverlayView.swift
//  OverlayOptions
//
//  Created by Thaihoa on 9/24/15.
//  Copyright © 2015 Thaihoa. All rights reserved.
//

import UIKit

protocol HTOverlayViewTouchDelegate{
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    func touchType1(sender: AnyObject!)
    func touchType2(sender: AnyObject!)
    func touchType3(sender: AnyObject!)
    func touchType4(sender: AnyObject!)
    func touchType5(sender: AnyObject!)
}


class HTOverlayViewButton{
    init(id: String, text: String, image: UIImage? = nil ){
        self.id = id
        self.text = text
        self.image = image
    }
    
    var id: String!
    var text: String!
    var image: UIImage?
}

class HTOverlayViewContainerView: UIView{
    var delegate: HTOverlayViewTouchDelegate?
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(delegate != nil){
            delegate?.touchesBegan(touches, withEvent: event)
        }
    }
    
    func touchType1(sender: AnyObject!) {
        self.delegate?.touchType1(sender)
    }
    
    func touchType2(sender: AnyObject!) {
        self.delegate?.touchType2(sender)
    }
    
    func touchType3(sender: AnyObject!) {
        self.delegate?.touchType3(sender)
    }
    
    func touchType4(sender: AnyObject!) {
        self.delegate?.touchType4(sender)
    }
    
    func touchType5(sender: AnyObject!) {
        self.delegate?.touchType5(sender)
    }
}

class HTOverlayViewConfig{
    init(){
    }
    
    var durationIn: Double = 0.2
    var durationOut: Double = 0.2
    var overlayColor = UIColor.blackColor()
    var buttonBackColor = UIColor.whiteColor()
    var buttonForceColor = UIColor.blueColor()
}

class HTOverlayView: HTOverlayViewTouchDelegate {
    var controller: UIViewController!
    private var mainView: HTOverlayViewContainerView!
    private var overlayView: UIView!
    private var config: HTOverlayViewConfig!
    private var buttons: [HTOverlayViewButton]!
    
    init(_controller: UIViewController, config: HTOverlayViewConfig? = nil){
        self.controller = _controller
        
        if(config == nil){
            self.config = HTOverlayViewConfig()
        }else{
            self.config = config
        }
        
        mainView = HTOverlayViewContainerView(frame: controller.view.bounds)
        mainView.delegate = self
        controller.view.addSubview(mainView)
        mainView.hidden = true
        initOverlayView()
    }
    
    func initOverlayView(){
        overlayView = UIView(frame: self.mainView.bounds)
        overlayView.backgroundColor = self.config.overlayColor
        mainView.addSubview(overlayView)
        overlayView.alpha = 0
    }
    
    
    func show(){
        self.mainView.hidden = false
        UIView.animateWithDuration(config.durationIn, animations: {() -> Void in
            self.overlayView.alpha = 0.7
            self.addShow()
            
        })
    }
    
    func addHide(){
    }
    
    func addShow(){
    }
    
    func hide(){
        UIView.animateWithDuration(config.durationOut, animations: {() -> Void in
            self.overlayView.alpha = 0
            self.addHide()
            
            },
            completion: {(complete) -> Void in
                self.mainView.hidden = true
        })
        
    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.hide()
    }
    
    func touchType1(sender: AnyObject!) {
        
    }
    
    func touchType3(sender: AnyObject!) {
        
    }
    
    func touchType4(sender: AnyObject!) {
        
    }
    
    func touchType5(sender: AnyObject!) {
        
    }
    
    func touchType2(sender: AnyObject!) {
        
    }
    
}


class HTOverlayWithButtonsView: HTOverlayView{
    var buttonData: [HTOverlayViewButton]!
    var buttonView: [UIButton]! = [UIButton]()
    var buttonOriginalPos: [CGPoint]! = [CGPoint]()
    var buttonOffsetPos: [CGPoint]! = [CGPoint]()
    
    init(_controller: UIViewController, buttons: [HTOverlayViewButton], config: HTOverlayViewConfig? = nil){
        super.init(_controller: _controller, config: config)
        buttonData = buttons
        
        var height: CGFloat = 150
        var alt = false
        let offset = self.controller.view.bounds.width
        var buttonTag = 0
        for btnData in self.buttonData{
            let btn = UIButton(frame: CGRectMake(0,0,80,80))
            btn.layer.cornerRadius = btn.frame.size.width / 2.0
            btn.backgroundColor = self.config.buttonBackColor
            btn.setTitleColor(self.config.buttonForceColor, forState: UIControlState.Normal)
            let pos = CGPointMake(mainView.center.x, height)
            let offsetPos = CGPointMake(
                alt == true ? (mainView.center.x + offset): (mainView.center.x - offset), height)
            alt = !alt
            
            buttonOffsetPos.append(offsetPos)
            buttonOriginalPos.append(pos)
            
            btn.center = offsetPos
            btn.setTitle(btnData.text, forState: UIControlState.Normal)
            mainView.addSubview(btn)
            buttonView.append(btn)
            height += 90
            
            btn.tag = buttonTag
            buttonTag++
            btn.addTarget(mainView, action: "touchType1:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }
    
    override func touchType1(sender: AnyObject!) {
        var btn = sender as! UIButton
        print("touchType1: \(btn.tag)")
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            btn.backgroundColor = UIColor.orangeColor()
            }, completion: {(complete)-> Void in
                self.hide()
        })
    }
    
    
    override func addShow() {
        for (var i = 0; i < self.buttonView.count; i++){
            buttonView[i].center = buttonOriginalPos[i]
        }
    }
    
    
    override func addHide() {
        for (var i = 0; i < self.buttonView.count; i++){
            buttonView[i].center = buttonOffsetPos[i]
        }
    }
    
}

