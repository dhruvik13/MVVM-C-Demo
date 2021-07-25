//
//  LoadingViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import UIKit

public enum LoadingViewState {
    case loading
    case failure(message: String?, retryAction: (() -> Void)? = nil)
    case hidden
}

public class LoadingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var errorView: UIView! {
        didSet {
            errorView.isHidden = true
        }
    }
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var retryButton: UIButton!
    
    private var state: LoadingViewState = .loading
    
    private var retryAction: (() -> Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public var onViewWillAppear: (() -> Void)?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear?()
    }

    public var onViewDidAppear: ((UIViewController) -> Void)?
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onViewDidAppear?(self)
    }

    public func setLoadingState(_ state: LoadingViewState) {
        switch state {
        case .loading:
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            errorView.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        case .failure(let message, let retryAction):
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            activityIndicator.stopAnimating()
            errorView.isHidden = false
            errorMessageLabel.text = message
            self.retryAction = retryAction
        case .hidden:
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            activityIndicator.stopAnimating()
        }
    }

    @IBAction func handleTapRetry(_ sender: Any) {
        retryAction?()
    }
    
    public static func vend() -> LoadingViewController {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("couldn't load \(className) as \(type(of: self))")
        }
        return vc
    }
    
    deinit {
        print("CPU can reclaim memory for \(LoadingViewController.self) - No Retail Cycle/Leak")
    }
}
