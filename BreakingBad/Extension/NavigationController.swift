//
//  NavigationController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import UIKit

extension UINavigationController {
    public func pushByReplacingLast(_ viewController: UIViewController, animated: Bool) {
        var stack = viewControllers
        _ = stack.popLast()
        setViewControllers(stack + [viewController], animated: animated)
    }
}
