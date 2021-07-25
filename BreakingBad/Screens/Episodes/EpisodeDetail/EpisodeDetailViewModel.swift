//
//  EpisodeDetailViewModel.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import Foundation

protocol EpisodeDetailViewModelConsumer: AnyObject {
    func setEpisodeDetail(episode: Episode)
}

class EpisodeDetailViewModel: EpisodeDetailViewModelType {
    var title: String = ""
    
    private weak var consumer: EpisodeDetailViewModelConsumer?
    private var selectedEpisode: Episode
    
    init(consumer: EpisodeDetailViewModelConsumer?,
         selectedEpisode: Episode) {
        self.consumer = consumer
        self.selectedEpisode = selectedEpisode
        title = selectedEpisode.title
    }
    
    func setInitialDetails() {
        consumer?.setEpisodeDetail(episode: selectedEpisode)
    }
}

