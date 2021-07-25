//
//  BreakingBadAPITarget.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

public enum BreakingBadAPITarget {
    /// /api/characters
    case getAllCharacters
    /// /api/characters/{_characterId_}
    case getSingleCharacter(characterId: Int)
    /// /api/episodes
    case getAllEpisodes
    /// /api/episodes/{_episodeId_}
    case getSingleEpisode(episodeId: Int)
    /// /api/quotes
    case getAllQuotes
    /// /api/quotes/{_quoteId_}
    case getSingleQuote(quoteId: Int)
}

extension BreakingBadAPITarget: BreakingBadTargetType {
    public var path: String {
        switch self {
        case .getAllCharacters:
            return "/api/characters"
        case .getSingleCharacter(let characterId):
            return "/api/characters/\(characterId)"
        case .getAllEpisodes:
            return "/api/episodes"
        case .getSingleEpisode(let episodeId):
            return "/api/episodes/\(episodeId)"
        case .getAllQuotes:
            return "/api/quotes"
        case .getSingleQuote(let quoteId):
            return "/api/quotes/\(quoteId)"
        }
    }
    
    public var method: Core.Method {
        switch self {
        case .getAllCharacters,
             .getSingleCharacter,
             .getAllEpisodes,
             .getSingleEpisode,
             .getAllQuotes,
             .getSingleQuote:
            
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getAllCharacters,
             .getSingleCharacter,
             .getAllEpisodes,
             .getSingleEpisode,
             .getAllQuotes,
             .getSingleQuote:
            return nil
        }
    }
    
    public var body: Data? {
        return nil
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
