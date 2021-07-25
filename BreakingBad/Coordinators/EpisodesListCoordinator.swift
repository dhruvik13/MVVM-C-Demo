//
//  EpisodesListCoordinator.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import UIKit

class EpisodesListCoordinator {
    
    private let interactor: EpisodesFetchInteractor
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController, interactor: EpisodesFetchInteractor = EpisodesFetchInteractor()) {
        self.presenter = presenter
        self.interactor = interactor
    }
    
    func start() {
        let loadingVC = LoadingViewController.vend()
        loadingVC.onViewWillAppear = { [weak self] in
            func fetchEpisodes() {
                loadingVC.setLoadingState(.loading)
                self?.interactor.getEpisodes { [weak self] result in
                    switch result {
                    case .failure(let error):
                        guaranteeMainThread {
                            loadingVC.setLoadingState(.failure(message: BreakingBadError.normalizeError(error).errorDescription,
                                                               retryAction: {
                                                                    fetchEpisodes()
                                                               }))
                        }
                    case .success(let episodes):
                        guaranteeMainThread {
                            if (self?.presenter.viewControllers.contains(loadingVC) ?? false) {
                                loadingVC.setLoadingState(.hidden)
                                self?.showEpisodesList(episodes)
                            }
                        }
                    }
                }
            }
            fetchEpisodes()
        }
        presenter.pushViewController(loadingVC, animated: true)
    }
    
    private func showEpisodesList(_ episodes: Episodes) {
        let vc = EpisodesViewController.create { vc in
            return EpisodesViewModel(consumer: vc as? EpisodesViewModelConsumer,
                                     seriesEpisodes: episodes,
                                     action: .init(showSingleEpisodeDetail: {
                                        self.showSelectedEpisode(episodeId: $0)
                                     }))
        }
        presenter.pushByReplacingLast(vc, animated: false)
    }
    
    private func showSelectedEpisode(episodeId: Int) {
        let loadingVC = LoadingViewController.vend()
        loadingVC.onViewWillAppear = { [weak self] in
            func fetchSingleEpisode() {
                loadingVC.setLoadingState(.loading)
                self?.interactor.getSelectedEpisodeDetail(with: episodeId) { result in
                    switch result {
                    case .failure(let error):
                        guaranteeMainThread {
                            loadingVC.setLoadingState(.failure(message: BreakingBadError.normalizeError(error).errorDescription,
                                                               retryAction: {
                                                                fetchSingleEpisode()
                                                               }))
                        }
                    case .success(let episodes):
                        guaranteeMainThread {
                            if (self?.presenter.viewControllers.contains(loadingVC) ?? false) {
                                loadingVC.setLoadingState(.hidden)
                                let vc = EpisodeDetailViewController.create { vc in
                                    return EpisodeDetailViewModel(consumer: vc as? EpisodeDetailViewController,
                                                                  selectedEpisode: episodes[0])
                                }
                                self?.presenter.pushByReplacingLast(vc, animated: false)
                            }
                        }
                    }
                }
            }
            fetchSingleEpisode()
        }
        presenter.pushViewController(loadingVC, animated: true)
    }
}
