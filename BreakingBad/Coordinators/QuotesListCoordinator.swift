//
//  QuotesListCoordinator.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import UIKit

class QuotesListCoordinator {
    
    private let interactor: QuotesFetchInteractor
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController, interactor: QuotesFetchInteractor = QuotesFetchInteractor()) {
        self.presenter = presenter
        self.interactor = interactor
    }
    
    func start() {
        let loadingVC = LoadingViewController.vend()
        loadingVC.onViewWillAppear = { [weak self] in
            func getQuotes() {
                loadingVC.setLoadingState(.loading)
                self?.interactor.getQuotes { [weak self] result in
                    switch result {
                    case .failure(let error):
                        guaranteeMainThread {
                            loadingVC.setLoadingState(.failure(message: BreakingBadError.normalizeError(error).errorDescription,
                                                               retryAction: {
                                                                getQuotes()
                                                               }))
                        }
                    case .success(let quotes):
                        guaranteeMainThread {
                            if self?.presenter.viewControllers.contains(loadingVC) ?? false {
                                loadingVC.setLoadingState(.hidden)
                                self?.showQuotesList(quotes)
                            }
                        }
                    }
                }
            }
            getQuotes()
        }
        presenter.pushViewController(loadingVC, animated: true)
    }
    
    private func showQuotesList(_ quotes: Quotes) {
        let vc = QuotesViewController.create { vc in
            return QuotesViewModel(consumer: vc as? QuotesViewModelConsumer, seriesQuotes: quotes, action: .init(showSingleQuoteDetail: {
                self.showSelectedQuotes(quotesId: $0)
            }))
        }
        presenter.pushByReplacingLast(vc, animated: false)
    }
    
    private func showSelectedQuotes(quotesId: Int) {
        interactor.getSelectedQuoteDetail(with: quotesId) { result in
            let quote = (try? result.get())?.first
            print(quote?.author ?? "No author")
        }
    }
}
