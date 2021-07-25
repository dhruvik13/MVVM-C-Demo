//
//  QuotesFetchInteractor.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import Foundation

protocol QuotesProvider: AnyObject {
    func getQuotes(completion: @escaping (Result<Quotes, Error>) -> Void)
    func getSelectedQuoteDetail(with quoteId: Int, completion: @escaping (Result<Quotes, Error>) -> Void)
}

class QuotesFetchInteractor: QuotesProvider {
    func getQuotes(completion: @escaping (Result<Quotes, Error>) -> Void) {
        BreakingBadAPITarget.getAllQuotes.fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let jsonResponse):
                do {
                    let decodedResponse = try JSONDecoder().decode(Quotes.self, from: jsonResponse)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(BreakingBadError.normalizeError(error)))
                }
            }
        }
    }
    
    func getSelectedQuoteDetail(with quoteId: Int, completion: @escaping (Result<Quotes, Error>) -> Void) {
        BreakingBadAPITarget.getSingleQuote(quoteId: quoteId).fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let jsonResponse):
                do {
                    let decodedResponse = try JSONDecoder().decode(Quotes.self, from: jsonResponse)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(BreakingBadError.normalizeError(error)))
                }
            }
        }
    }
}
