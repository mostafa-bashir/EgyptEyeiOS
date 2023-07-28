//
//  NetworkListner.swift
//  CombineWithAlamofire
//
//  Created by Mostafa Bashir on 25/03/2023.
//

import Foundation
import Network
import Alamofire
import UIKit

class NetworkManager {
    
    let monitor = NWPathMonitor()
    static let shared = NetworkManager()
//    var manager = NetworkReachabilityManager()
//
//    fileprivate var isReachable = false
//
//    func startMoni(){
//        self.manager?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: {(networkStatus) in
//
//            if networkStatus == .reachable(.cellular) || networkStatus == .reachable(.ethernetOrWiFi) {
//                self.isReachable = true
//            }else{
//                self.isReachable = false
//            }
//        })
//    }
//
//    func isConnected() -> Bool {
//        return self.isReachable
//    }
    
    
    //MARK: used to listen to network state
    func listen() {
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
    }
    
    func configureVC(vc:UIViewController) {
        
        monitor.pathUpdateHandler = { path in
            
            
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Connection Error", message: "Check your internet connection", preferredStyle: UIAlertController.Style.alert)

            
            
            if path.status == .satisfied {
                print("We're connected!")
                            } else {
                print("No connection.")
            }}
            print(path.isExpensive)
        }
    }
    
}
