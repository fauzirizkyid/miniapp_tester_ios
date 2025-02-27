//
//  MiniAppTesterApp.swift
//  MiniAppTester
//
//  Created by Rizky Fauzi on 20/02/25.
//

import SwiftUI
import TCMPPSDK

@main
struct MiniAppTesterApp: App {
    let miniAppCustomization = MiniAppCustomization()

    init() {
        setupTCMPP()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupTCMPP() {
        
        if let fileURL = Bundle.main.url(forResource: "tcsas-ios-configurations", withExtension: "json") {
            let filePath = fileURL.path
            let config = TMAServerConfig(file: filePath)
            TMFMiniAppSDKManager.sharedInstance().setConfiguration(config)
            TMFMiniAppSDKManager.sharedInstance().miniAppSdkDelegate = miniAppCustomization
            print("✅ TCMPP SDK Initialized Successfully!")
        } else {
            print("❌ TCMPP Config file not found!")
        }
    }
}
