//
//  PollingViewController.swift
//  Beacon Demo
//
//  Created by Scott Matheson on 11/16/18.
//  Copyright © 2018 HarborIO, Inc. All rights reserved.
//

import UIKit

class PollingViewController: UIViewController {
    @IBOutlet var statusTextView: UITextView!
    
    public var currentCount : Double? = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self.currentCount ?? 0.0)
        let ct = Int(self.currentCount!)
        
        if ct == 1 {
            self.statusTextView.text = "You are the first to make that choice"
        } else {
            self.statusTextView.text = "\(ct) people have made that choice"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VA: " + String(describing: self.title))
        //print("Int\(String(describing: self.currentCount))")
        HarborLogger.startScreenDwell(self.title!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("VD: " + String(describing: self.title))
        HarborLogger.stopScreenDwell(self.title!)
    }
    


}
