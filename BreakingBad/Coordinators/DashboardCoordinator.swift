//
//  DashboardCoordinator.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import UIKit

class DashboardCoordinator {
    
    let presenter: UINavigationController
    
    var charactersCoordinator: CharactersListCoordinator?
    var episodesCoordinator: EpisodesListCoordinator?
    var quotesCoordinator: QuotesListCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let vc = DashboardViewController.create { _ in
            return DashboardViewModel(actionHandler: .init(showCharacters: showAllCharacters,
                                                           showEpisodes: showAllEpisode,
                                                           showQuotes: showAllQuotes)
            )
        }
        presenter.setViewControllers([vc], animated: true)
    }
    
    private func showAllCharacters() {
        charactersCoordinator = CharactersListCoordinator(presenter: presenter)
        charactersCoordinator?.start()
    }
    
    private func showAllEpisode() {
        episodesCoordinator = EpisodesListCoordinator(presenter: presenter)
        episodesCoordinator?.start()
    }
    
    private func showAllQuotes() {
        quotesCoordinator = QuotesListCoordinator(presenter: presenter)
        quotesCoordinator?.start()
    }
}
