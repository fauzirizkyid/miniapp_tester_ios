//
//  MiniAppService.swift
//  MiniAppTester
//
//  Created by Rizky Fauzi on 20/02/25.
//

import UIKit
import TCMPPSDK

class MiniAppService: MiniAppRepository {
    func launchMiniApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootVC = window.rootViewController else {
            print("❌ No valid UIViewController found.")
            return
        }

        TMFMiniAppSDKManager.sharedInstance().startUpMiniApp(
            withAppID: "mp4kazz34av9riuw",
            parentVC: rootVC
        ) { error in
            if let error = error {
                print("❌ Failed to launch MiniApp: \(error.localizedDescription)")
            } else {
                print("✅ MiniApp launched successfully!")
            }
        }
    }
}
