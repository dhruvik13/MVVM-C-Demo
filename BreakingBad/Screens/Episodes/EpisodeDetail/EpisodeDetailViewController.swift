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
    @IBOutlet weak var episodeNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialDetails()
    }
}

extension EpisodeDetailViewController: EpisodeDetailViewModelConsumer {
    func setEpisodeDetail(episode: Episode) {
        title = episode.title
        seriesWithSeasonLabel.text = String("This episode is part of series: (\(episode.series)) in season (\(episode.season)).\n Which was aired on \(episode.airDate).")
        episodeCharactersLabel.text = episode.characters.joined(separator: ", ")
        episodeNumber.font = UIFont.italicSystemFont(ofSize: 13.0)
        episodeNumber.text = "(episode #\(episode.episodeID))"
    }
}
