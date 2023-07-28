//
//  EgyptEyeApp.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import SwiftUI

@main
struct EgyptEyeApp: App {
    var body: some Scene {
        WindowGroup {
            
            if UserDefaults.standard.string(forKey: "token") == nil{
                LoginView()
            }else{
                TabBarView()
            }
        }
    }
}
