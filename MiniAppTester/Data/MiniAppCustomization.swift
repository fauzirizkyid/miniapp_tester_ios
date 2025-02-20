//
//  MiniAppCustomization.swift
//  MiniAppTester
//
//  Created by Rizky Fauzi on 20/02/25.
//

import UIKit
import TCMPPSDK

class MiniAppCustomization: NSObject, TMFMiniAppSDKDelegate {
    // ✅ 1️⃣ Customize Loading Screen
    func customLoadingView(with appInfo: TMFMiniAppInfo?, frame: CGRect) -> UIView? {
        print("Custom loading view is being used.")
        let view = UIView(frame: frame)
        view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 20, y: frame.height / 2 - 10, width: frame.width - 40, height: 20))
        label.text = "Loading MiniApp..."
        label.textColor = .black
        label.textAlignment = .center
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = CGPoint(x: frame.width / 2, y: frame.height / 2 + 20)
        activityIndicator.startAnimating()
        
        view.addSubview(label)
        view.addSubview(activityIndicator)
        
        return view
    }
    
    // ✅ 2️⃣ Customize Navigation Bar Buttons
    func string(withConfigKey key: String) -> String {
        switch key {
        case "TMA_SK_MINIAPP_CloseButton":
            return Bundle.main.path(forResource: "Resources/Images/ic_power_24", ofType: "png") ?? ""
        case "TMA_SK_MINIAPP_CloseButtonDark":
            return Bundle.main.path(forResource: "Resources/Images/ic_power_24", ofType: "png") ?? ""
        case "TMA_SK_MINIAPP_BackButton":
            return Bundle.main.path(forResource: "Resources/Images/ic_power_24", ofType: "png") ?? ""
        case "TMA_SK_MINIAPP_MoreButton":
            return Bundle.main.path(forResource: "Resources/Images/ic_power_24", ofType: "png") ?? ""
        default:
            return ""
        }
    }
    
    // ✅ 3️⃣ Customize More Menu (Sharing & Actions)
    //    func customizedConfigForShare() -> [TMASheetItemInfo] {
    //        var items = [TMASheetItemInfo]()
    //
    //        let shareItem = TMASheetItemInfo(title: "Share", type: .customizedShare)
    //        shareItem.icon = UIImage(named: "Resources/Images/icon_share")
    //        items.append(shareItem)
    //
    //        let feedbackItem = TMASheetItemInfo(title: "Send Feedback", type: .customizedAction)
    //        feedbackItem.icon = UIImage(named: "Resources/Images/icon_feedback")
    //        items.append(feedbackItem)
    //
    //        return items
    //    }
    
    // ✅ 4️⃣ Customize Startup Animation
    func getTMFSlideAnimationType() -> TMFSlideAnimationType {
        return .bottomToTop // Options: .leftToRight, .rightToLeft, .topToBottom, .fade
    }
    
    // ✅ 5️⃣ Customize Authorization Dialog (Permissions)
    func createAuthorizeAlertView(
        withFrame frame: CGRect,
        scope: String,
        title: String,
        desc: String,
        privacyApi: String,
        appInfo: TMFMiniAppInfo?,
        allow allowBlock: @escaping () -> Void,
        denyBlock: @escaping () -> Void
    ) -> UIView {
        
        let alertView = UIView(frame: frame)
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 12
        alertView.layer.shadowOpacity = 0.3
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: 20))
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let descLabel = UILabel(frame: CGRect(x: 10, y: 40, width: frame.width - 20, height: 40))
        descLabel.text = desc
        descLabel.numberOfLines = 2
        descLabel.textAlignment = .center
        descLabel.textColor = .gray
        alertView.addSubview(descLabel)
        
        let allowButton = UIButton(frame: CGRect(x: 20, y: 90, width: frame.width - 40, height: 30))
        allowButton.setTitle("Allow", for: .normal)
        allowButton.backgroundColor = .systemBlue
        allowButton.layer.cornerRadius = 8
        allowButton.addTarget(self, action: #selector(allowPressed), for: .touchUpInside)
        alertView.addSubview(allowButton)
        
        let denyButton = UIButton(frame: CGRect(x: 20, y: 130, width: frame.width - 40, height: 30))
        denyButton.setTitle("Deny", for: .normal)
        denyButton.backgroundColor = .systemRed
        denyButton.layer.cornerRadius = 8
        denyButton.addTarget(self, action: #selector(denyPressed), for: .touchUpInside)
        alertView.addSubview(denyButton)
        
        return alertView
    }
    
    @objc private func allowPressed() {
        print("✅ Permission Granted")
    }
    
    @objc private func denyPressed() {
        print("❌ Permission Denied")
    }
}

