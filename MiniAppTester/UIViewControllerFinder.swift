import UIKit
import SwiftUI

struct UIViewControllerFinder: UIViewControllerRepresentable {
    var callback: (UIViewController?) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            self.callback(viewController.view.window?.rootViewController)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
