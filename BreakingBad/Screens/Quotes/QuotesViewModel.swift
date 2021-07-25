//
//  QuotesViewModel.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

protocol QuotesViewModelConsumer: AnyObject {
    func setQuotes(quoteList: Quotes)
}

class QuotesViewModel: QuotesViewModelType {
    struct Actions {
        let showSingleQuoteDetail: (Int) -> Void
    }
    
    var title: String = "Quotes"
    
    private weak var consumer: QuotesViewModelConsumer?
    private var seriesQuotes: Quotes
    private var actionHandler: Actions
    private var quoteDetailProvider: QuotesProvider
    
    init(consumer: QuotesViewModelConsumer?,
         seriesQuotes: Quotes,
         action: Actions,
         quoteDetailProvider: QuotesProvider = QuotesFetchInteractor()) {
        self.consumer = consumer
        self.seriesQuotes = seriesQuotes
        self.quoteDetailProvider = quoteDetailProvider
        self.actionHandler = action
    }
    
    func setInitialDetails() {
        consumer?.setQuotes(quoteList: seriesQuotes)
    }
    
    func showQuotesDetailWith(quotesId: Int) {
        actionHandler.showSingleQuoteDetail(quotesId)
    }
}
