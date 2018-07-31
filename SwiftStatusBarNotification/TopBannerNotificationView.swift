//
//  ViewController.swift
//  SwiftStatusBarNotification
//
//  Created by Sanjeev Gautam on 31/07/18.
//  Copyright © 2018 SWS. All rights reserved.
//

import Foundation
import UIKit

private let ANIMATION_DURATION = 0.3
private let NOTIFICATION_HEIGHT: CGFloat = UIApplication.shared.statusBarFrame.height
private let NOTIFICATION_DISPLAY_TIME = 2.0
private let SCREEN_SIZE = UIScreen.main.bounds
private let APP_WINDOW = (UIApplication.shared.delegate as? AppDelegate)?.window
private let NOTIFICATION_BACKGROUND_COLOR = UIColor.purple
private let NOTIFICATION_FONT = UIFont.systemFont(ofSize: 13)

class TopBannerNotificationView {
    
    private init() { }
    static private var notificationView: UIView?
    
    // Show Notification
    static func showNotification(message: String) {
        if notificationView != nil {
            return
        }
        
        let rect = CGRect(x: 0.0, y: -NOTIFICATION_HEIGHT, width: SCREEN_SIZE.width, height: NOTIFICATION_HEIGHT)
        self.notificationView = UIView(frame: rect)
        if let notiView = self.notificationView {
            notiView.backgroundColor = NOTIFICATION_BACKGROUND_COLOR
            
            APP_WINDOW?.addSubview(notiView)
            self.setWindowLevel(willNotificationDisplay: true)
            
            var labelheight = UIApplication.shared.statusBarFrame.height
            if labelheight > 20.0 {
                labelheight = 15.0
            }
            let label = UILabel(frame: CGRect(x: 5, y: notiView.frame.size.height-labelheight, width: notiView.frame.size.width - 10, height: labelheight))
            label.textColor = UIColor.white
            label.text = message
            label.font = NOTIFICATION_FONT
            label.numberOfLines = 1
            label.textAlignment = .center
            notiView.addSubview(label)
            
            self.moveNotificationView(withAnimation: true)
            
            Timer.scheduledTimer(timeInterval: NOTIFICATION_DISPLAY_TIME, target: self, selector: #selector(self.timerMethod), userInfo: true, repeats: false)
        }
    }
    
    // MARK:- Private Methods
    // automatically remove view after few seconds via timer
    @objc static private func timerMethod(timer: Timer) {
        if let animation = timer.userInfo as? Bool {
            self.removeNotificationView(withAnimation: animation)
        } else {
            self.removeNotificationView(withAnimation: true)
        }
    }
    
    // show view
    static private func moveNotificationView(withAnimation: Bool) {
        if withAnimation {

            UIView.animate(withDuration: ANIMATION_DURATION) {
                let rect = CGRect(x: 0.0, y: 0.0, width: SCREEN_SIZE.width, height: NOTIFICATION_HEIGHT)
                self.notificationView?.frame = rect
            }
        } else {
            let rect = CGRect(x: 0.0, y: 0.0, width: SCREEN_SIZE.width, height: NOTIFICATION_HEIGHT)
            self.notificationView?.frame = rect
        }
    }
    
    // remove view
    static private func removeNotificationView(withAnimation: Bool) {
        if withAnimation {
            
            UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                
                let rect = CGRect(x: 0.0, y: -NOTIFICATION_HEIGHT, width: SCREEN_SIZE.width, height: NOTIFICATION_HEIGHT)
                self.notificationView?.frame = rect
            }) { (success) in
                self.notificationView?.removeFromSuperview()
                self.notificationView = nil
                self.setWindowLevel(willNotificationDisplay: false)
            }
        } else {
            let rect = CGRect(x: 0.0, y: -NOTIFICATION_HEIGHT, width: SCREEN_SIZE.width, height: NOTIFICATION_HEIGHT)
            self.notificationView?.frame = rect

            self.notificationView?.removeFromSuperview()
            self.notificationView = nil
            self.setWindowLevel(willNotificationDisplay: false)
        }
    }
    
    // show hide status bar during view
    static private func setWindowLevel(willNotificationDisplay: Bool) {
        if willNotificationDisplay {
            APP_WINDOW?.windowLevel = UIWindowLevelStatusBar + 1
        } else {
            APP_WINDOW?.windowLevel = UIWindowLevelStatusBar - 1
        }
    }
    
}
