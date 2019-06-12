//
//  InterfaceController.swift
//  WatchTransferDataDemo WatchKit Extension
//
//  Created by sotsys-236 on 12/06/19.
//  Copyright © 2019 sotsys-236. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity //**1

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var label: WKInterfaceLabel!//**2
    let session = WCSession.default//**3
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        session.delegate = self//**4
        session.activate()//**5
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func tapSendToiPhone() {//**6
        let data: [String: Any] = ["watch": "data from watch" as Any] //Create your dictionary as per uses
        session.transferUserInfo(data)//**6.1
    }
}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {//**7
        print("received data: \(userInfo)")
        if let value = userInfo["iPhone"] as? String {//**7.1
            self.label.setText(value)
        }
    }
}
