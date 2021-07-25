//
//  EpisodesViewModel.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

protocol EpisodesViewModelConsumer: AnyObject {
    func setEpisodess(episodesList: Episodes)
}

class EpisodesViewModel: EpisodesViewModelType {
    struct Actions {
        let showSingleEpisodeDetail: (Int) -> Void
    }
    
    var title: String = "Episodes"
    
    private weak var consumer: EpisodesViewModelConsumer?
    private var actionHandler: Actions
    private var seriesEpisodes: Episodes
    private var episodeDetailProvider: EpisodesProvider
    
    init(consumer: EpisodesViewModelConsumer?,
         seriesEpisodes: Episodes,
         action: Actions,
         episodeDetailProvider: EpisodesProvider = EpisodesFetchInteractor()) {
        self.consumer = consumer
        self.seriesEpisodes = seriesEpisodes
        self.episodeDetailProvider = episodeDetailProvider
        self.actionHandler = action
    }
    
    func setInitialDetails() {
        consumer?.setEpisodess(episodesList: seriesEpisodes)
    }
    
    func showEpisodeDetailWith(episodeId: Int) {
        actionHandler.showSingleEpisodeDetail(episodeId)
    }
}
