//
//  ViewController.swift
//  SwiftStatusBarNotification
//
//  Created by Sanjeev Gautam on 31/07/18.
//  Copyright © 2018 SWS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showNotification(_ sender: UIButton) {
        TopBannerNotificationView.showNotification(message: "Here is your notification.")
    }
}

