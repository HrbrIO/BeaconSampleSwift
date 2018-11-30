//
//  PollingViewController.swift
//  BeaconSampleSwift
//
//  Created by Scott Matheson on 11/16/18.
//  Copyright © 2018 HarborIO, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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
