//
//  ViewController.swift
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

class ViewController: UIViewController {
    @IBOutlet var pollResultsTextField: UITextField!
    
    func logPollResults() {
    
        let d = ["count":   ["empty": self.emptyInt(), "full": self.fullInt()],
                 "percent": ["empty": self.emptyPercentage(), "full": self.fullPercentage()]]
        
        HarborLogger.log("POLL_RESULTS", data: d)
    }
    
    func updatePollResults() {
        let s = "Empty: \(self.emptyPercentage())%, Full: \(self.fullPercentage())%"
        self.pollResultsTextField.text = s
        self.logPollResults()
        print(s)
    }
    
    @IBAction func clickedFull(_ sender: Any) {
        self.pollStats["full"] = self.pollStats["full"]! + 1.0
        let d = ["page": self.title!, "button": "full"]
        HarborLogger.log("BUTTON_SELECT", data: d)
        self.updatePollResults()
    }
    
    @IBAction func clickedEmpty(_ sender: Any) {
        self.pollStats["empty"] = self.pollStats["empty"]! + 1.0
        let d = ["page": self.title!, "button": "empty"]
        HarborLogger.log("BUTTON_SELECT", data: d)
        self.updatePollResults()
    }
    
    var pollStats = ["empty": 0.0, "full": 0.0]

    func emptyInt() -> Int {
        let res = Double(self.pollStats["empty"] ?? 0.0)
        //return String(Int(res))
        return Int(res)
    }

    func fullInt() -> Int {
        let res = Double(self.pollStats["full"] ?? 0.0)
        //return String(Int(res))
        return Int(res)
    }

    func emptyPercentage() -> String {
        let empty = Double(self.pollStats["empty"] ?? 0.0)
        let full  = Double(self.pollStats["full"] ?? 0.0)
        let res = (empty + full) < 1.0 ? 0 : (100.0 * empty/(empty + full))
        return String(Int(res))
    }

    func fullPercentage() -> String {
        let empty = Double(self.pollStats["empty"] ?? 0.0)
        let full  = Double(self.pollStats["full"] ?? 0.0)
        let res = (empty + full) < 1.0 ? 0 : (100.0 * full/(empty + full))
        return String(Int(res))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //print(String(describing: self.title))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on this view controller
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updatePollResults()
        print("VA: " + String(describing: self.title))
        HarborLogger.startScreenDwell(self.title!)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("VD: " + String(describing: self.title))
        HarborLogger.stopScreenDwell(self.title!)
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmptySegue" {
            if let viewController = segue.destination as? PollingViewController {
                viewController.currentCount = self.pollStats["empty"]
            }
        } else if segue.identifier == "FullSegue" {
            if let viewController = segue.destination as? PollingViewController {
                viewController.currentCount = self.pollStats["full"]
            }
        }
    }
}

