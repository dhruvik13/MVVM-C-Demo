//
//  EpisodesFetchInteractor.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import Foundation

protocol EpisodesProvider: AnyObject {
    func getEpisodes(completion: @escaping (Result<Episodes, Error>) -> Void)
    func getSelectedEpisodeDetail(with episodeId: Int, completion: @escaping (Result<Episodes, Error>) -> Void)
}

class EpisodesFetchInteractor: EpisodesProvider {
    func getEpisodes(completion: @escaping (Result<Episodes, Error>) -> Void) {
        BreakingBadAPITarget.getAllEpisodes.fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let payload):
                do {
                    let decodedResponse = try JSONDecoder().decode(Episodes.self, from: payload)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(BreakingBadError.normalizeError(error)))
                }
            }
        }
    }
    
    func getSelectedEpisodeDetail(with episodeId: Int, completion: @escaping (Result<Episodes, Error>) -> Void) {
        BreakingBadAPITarget.getSingleEpisode(episodeId: episodeId).fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let payload):
                do {
                    let decodedResponse = try JSONDecoder().decode(Episodes.self, from: payload)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(BreakingBadError.normalizeError(error)))
                }
            }
        }
    }
}
