//
//  Quotes.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

// MARK: - Quote
struct Quote: Codable {
    let quoteID: Int
    let quote, author: String
    let series: String  // "Better Call Saul" ,  "Breaking Bad"

    enum CodingKeys: String, CodingKey {
        case quoteID = "quote_id"
        case quote, author, series
    }
}

typealias Quotes = [Quote]
