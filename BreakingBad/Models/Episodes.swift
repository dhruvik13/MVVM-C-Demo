//
//  Episodes.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

// MARK: - Episode
struct Episode: Codable, Equatable {
    let episodeID: Int
    let title, season, airDate: String
    let characters: [String]
    let episode: String
    let series: String  // "Better Call Saul" ,  "Breaking Bad"

    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case title, season
        case airDate = "air_date"
        case characters, episode, series
    }
}

typealias Episodes = [Episode]
