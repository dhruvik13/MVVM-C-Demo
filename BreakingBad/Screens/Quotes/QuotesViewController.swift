//
//  QuotesViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import Foundation

protocol QuotesViewModelType {
    var title: String { get set }
    func setInitialDetails()
    func showQuotesDetailWith(quotesId: Int)
}

class QuotesViewController: BaseViewController<QuotesViewModelType> {
    @IBAction func handleQuoteSelection(_ sender: Any) {
        viewModel.showQuotesDetailWith(quotesId: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialDetails()
    }
    
    @IBOutlet weak var listHolderView: ListCollectionView!
    
    deinit {
        print("CPU can reclaim memory for \(QuotesViewController.self) - No Retail Cycle/Leak")
    }
}

extension QuotesViewController: QuotesViewModelConsumer {
    func setQuotes(quoteList: Quotes) {
        title = viewModel.title
        listHolderView.createAndBindCollectionView(with: .init(cellType: QuotesSectionHandler(),
                                                               data: quoteList as [AnyObject]),
                                                   layout: .listLayout,
                                                   bindCollectionFor: .Quotes,
                                                   handleSelection: { tappedIndex in
                                                        print(tappedIndex)
                                                   })
    }
}
