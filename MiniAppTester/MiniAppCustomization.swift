import UIKit
import TCMPPSDK

class MiniAppCustomization: NSObject, TMFMiniAppSDKDelegate {
    
    // ✅ Customize Loading Screen
    func customLoadingView(with appInfo: TMFMiniAppInfo?, frame: CGRect) -> UIView? {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 20, y: frame.height / 2 - 10, width: frame.width - 40, height: 20))
        label.text = "Loading MiniApp..."
        label.textColor = UIColor.black
        label.textAlignment = .center
        
        view.addSubview(label)
        return view
    }
    
    // ✅ Customize Navigation Bar Buttons
    func string(withConfigKey key: String) -> String {
        if(key == "TMA_SK_MINIAPP_CloseButton"){
            if let image = UIImage(named: "refresh") {
                let imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
                view.addSubview(imageView)
            } else {
                print("❌ Image not found in Assets.xcassets")
            }
        }
    }
    
    // ✅ Customize More Menu (Sharing & Actions)
    func customizedConfigForShare() -> [TMASheetItemInfo] {
        var items = [TMASheetItemInfo]()
        
        let shareItem = TMASheetItemInfo(title: "Share", type: .customizedShare)
        shareItem.icon = UIImage(named: "icon_share")
        items.append(shareItem)
        
        let customItem = TMASheetItemInfo(title: "Custom Action", type: .customizedAction)
        customItem.icon = UIImage(named: "icon_custom")
        items.append(customItem)
        
        return items
    }
    
    // ✅ Customize Startup Animation
    func getTMFSlideAnimationType() -> TMFSlideAnimationType {
        return .bottomToTop // Can be .leftToRight, .rightToLeft, etc.
    }
    
    // ✅ Customize Permission Dialog
    func createAuthorizeAlertView(withFrame frame: CGRect, scope: String, title: String, desc: String, privacyApi: String, appInfo: TMFMiniAppInfo?, allow allowBlock: @escaping () -> Void, denyBlock: @escaping () -> Void) -> UIView {
        let alertView = UIView(frame: frame)
        alertView.backgroundColor = .white
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: 20))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let descLabel = UILabel(frame: CGRect(x: 10, y: 40, width: frame.width - 20, height: 40))
        descLabel.text = desc
        descLabel.textAlignment = .center
        alertView.addSubview(descLabel)
        
        let allowButton = UIButton(frame: CGRect(x: 20, y: 90, width: frame.width - 40, height: 30))
                allowButton.setTitle("Allow", for: .normal)
                allowButton.backgroundColor = .green
                allowButton.addTarget(self, action: #selector(allowPressed), for: .touchUpInside)
                alertView.addSubview(allowButton)

                let denyButton = UIButton(frame: CGRect(x: 20, y: 130, width: frame.width - 40, height: 30))
                denyButton.setTitle("Deny", for: .normal)
                denyButton.backgroundColor = .red
                denyButton.addTarget(self, action: #selector(denyPressed), for: .touchUpInside)
                alertView.addSubview(denyButton)

                return alertView
            }

            @objc private func allowPressed() {
                print("Permission Granted")
            }

            @objc private func denyPressed() {
                print("Permission Denied")
            }
        }
