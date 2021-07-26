//
//  CharactersListCoordinator.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import UIKit

class CharactersListCoordinator {
    
    private let interactor: CharactersFetchInteractor
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController, interactor: CharactersFetchInteractor = CharactersFetchInteractor()) {
        self.presenter = presenter
        self.interactor = interactor
    }
    
    func start() {
        let loadingVC = LoadingViewController.vend()
        loadingVC.onViewWillAppear = { [weak self] in
            func fetchCharacters() {
                loadingVC.setLoadingState(.loading)
                self?.interactor.getCharacters { result in
                    switch result {
                    case .failure(let error):
                        guaranteeMainThread {
                            loadingVC.setLoadingState(.failure(message: BreakingBadError.normalizeError(error).errorDescription,
                                                               retryAction: {
                                                                    fetchCharacters()
                                                               }))
                        }
                    case .success(let characters):
                        guaranteeMainThread {
                            if self?.presenter.viewControllers.contains(loadingVC) ?? false {
                                loadingVC.setLoadingState(.hidden)
                                self?.showCharacterList(characters)
                            }
                        }
                    }
                }
            }
            fetchCharacters()
        }
        presenter.pushViewController(loadingVC, animated: true)
    }
    
    private func showCharacterList(_ characters: Characters) {
        let vc = CharactersViewController.create { vc in
            return CharactersViewModel(consumer: vc as? CharactersViewModelConsumer,
                                       seriesCharacters: characters,
                                       action: .init(showSingleCharacterDetail: {
                                            self.showSelectedCharacter(characterId: $0)
                                        }))
        }
        
        presenter.pushByReplacingLast(vc, animated: false)
    }
    
    func showSelectedCharacter(characterId: Int) {
        let loadingVC = LoadingViewController.vend()
        
        loadingVC.onViewDidAppear = { [weak self] _ in
            
            func fetchSingleCharacter() {
                loadingVC.setLoadingState(.loading)
                
                self?.interactor.getSelectedCharacterDetail(with: characterId) { result in
                    switch result {
                    case .failure(let error):
                        guaranteeMainThread {
                            loadingVC.setLoadingState(.failure(message: BreakingBadError.normalizeError(error).errorDescription,
                                                               retryAction: {
                                                                fetchSingleCharacter()
                                                               }))
                        }
                    case .success(let characters):
                        guaranteeMainThread {
                            if self?.presenter.viewControllers.contains(loadingVC) ?? false {
                                loadingVC.setLoadingState(.hidden)
                                self?.showCharacterDetail(characters: characters)
                            }
                        }
                    }
                }
            }
            
            fetchSingleCharacter()
        }
        presenter.pushViewController(loadingVC, animated: true)
    }
    
    private func showCharacterDetail(characters: Characters) {
        let vc = CharacterDetailViewController.create { vc in
            return CharacterDetailViewModel(consumer: vc as? CharacterDetailViewController,
                                            selectedCharacter: characters[0])
        }
        presenter.pushByReplacingLast(vc, animated: false)
    }
}
