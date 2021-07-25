//
//  CharactersFetchInteractor.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import Foundation

protocol CharactersProvider: AnyObject {
    func getCharacters(completion: @escaping (Result<Characters, Error>) -> Void)
    func getSelectedCharacterDetail(with characterId: Int, completion: @escaping (Result<Characters, Error>) -> Void)
}

class CharactersFetchInteractor: CharactersProvider {
    func getCharacters(completion: @escaping (Result<Characters, Error>) -> Void) {
        BreakingBadAPITarget.getAllCharacters.fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let payload):
                do {
                    let decodedResponse = try JSONDecoder().decode(Characters.self, from: payload)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(BreakingBadError.normalizeError(error)))
                }
            }
        }
    }
    
    func getSelectedCharacterDetail(with characterId: Int ,
                                    completion: @escaping (Result<Characters, Error>) -> Void) {
        BreakingBadAPITarget.getSingleCharacter(characterId: characterId).fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let payload):
                do {
                    let decodedResponse = try JSONDecoder().decode(Characters.self, from: payload)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(BreakingBadError.normalizeError(error)))
                }
            }
        }
    }
}
