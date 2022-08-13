//
//  AppStoryboard.swift
//  KodaboveAssessment
//
//  Created by Drew Barnes on 11/08/2022.
//

import UIKit

enum AppStoryboard: String {
    case main = "Main"

    var instance: UIStoryboard {
        UIStoryboard(name: rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        return instance.instantiateViewController(
            withIdentifier: storyboardId
        ) as! T // swiftlint:disable:this force_cast
    }

    func viewControllerWithIdentifier<T: UIViewController>(viewControllerClass _: T.Type, identifier: String) -> T {
        instance.instantiateViewController(
            withIdentifier: identifier
        ) as! T // swiftlint:disable:this force_cast
    }

    func initialViewController() -> UIViewController? {
        instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardId: String {
        "\(self)"
    }

    var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }
        ).map { $0 as? UIWindowScene }.compactMap { $0 }.first?.windows.filter(\.isKeyWindow).first
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        appStoryboard.viewController(viewControllerClass: self)
    }
}
