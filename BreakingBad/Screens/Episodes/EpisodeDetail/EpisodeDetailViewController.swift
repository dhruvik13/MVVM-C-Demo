//
//  EpisodeDetailViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import UIKit

protocol EpisodeDetailViewModelType {
    var title: String { get set }
    func setInitialDetails()
}

class EpisodeDetailViewController: BaseViewController<EpisodeDetailViewModelType> {
    
    @IBOutlet weak var seriesWithSeasonLabel: UILabel!
    @IBOutlet weak var episodeCharactersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialDetails()
    }
}

extension EpisodeDetailViewController: EpisodeDetailViewModelConsumer {
    func setEpisodeDetail(episode: Episode) {
        title = episode.title
        seriesWithSeasonLabel.text = String("This episode is part of \(episode.series) in season \(episode.season). Which was aired on \(episode.airDate). (\(episode.episodeID))")
        episodeCharactersLabel.text = episode.characters.joined(separator: ", ")
    }
}

