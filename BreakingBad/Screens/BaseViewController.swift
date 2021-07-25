//
//  BaseViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import UIKit

public protocol HasChangeLayoutFunctionality {
    
}

open class BaseViewController<T>: UIViewController {
    open var viewModel: T!

    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemGray
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

public extension BaseViewController {
    static func create(viewModelFactory: (UIViewController) -> T) -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: Bundle(for:
                                                                        Self.self))
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("couldn't load \(className) as \(type(of: self))")
        }

        vc.viewModel = viewModelFactory(vc)

        return vc
    }
    
    static func vend() -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: Bundle(for:
                                                                        Self.self))
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("couldn't load \(className) as \(type(of: self))")
        }
        return vc
    }
}

public func guaranteeMainThread(_ work: @escaping () -> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async(execute: work)
    }
}
