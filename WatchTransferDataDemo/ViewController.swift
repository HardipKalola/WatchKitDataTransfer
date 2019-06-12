//
//  ViewController.swift
//  WatchTransferDataDemo
//
//  Created by sotsys-236 on 12/06/19.
//  Copyright © 2019 sotsys-236. All rights reserved.
//

import UIKit
import WatchConnectivity//1

class ViewController: UIViewController {
    
    var session: WCSession?//2
    @IBOutlet weak var label: UILabel!//3
    let tappedValue = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureWatchKitSesstion()//4
    }
    
    func configureWatchKitSesstion() {
        
        if WCSession.isSupported() {//4.1
            session = WCSession.default//4.2
            session?.delegate = self//4.3
            session?.activate()//4.4
        }
    }
    //5
    @IBAction func sendDataToWatchTapped(_ sender: Any) {
//        tappedValue ++
        if let validSession = self.session {//5.1
            let data: [String: Any] = ["iPhone": "Data from iPhone" as Any] // Create your Dictionay as per uses
            validSession.transferUserInfo(data)
        }
    }
}

// WCSession delegate functions
extension ViewController: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("received data: \(userInfo)")
        DispatchQueue.main.async { //6
            if let value = userInfo["watch"] as? String {
                self.label.text = value
            }
        }
    }
}
