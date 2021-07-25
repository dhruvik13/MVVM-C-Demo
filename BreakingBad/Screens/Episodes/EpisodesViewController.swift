//
//  EpisodesViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import Foundation

protocol EpisodesViewModelType {
    var title: String { get set }
    func setInitialDetails()
    func showEpisodeDetailWith(episodeId: Int)
}

class EpisodesViewController: BaseViewController<EpisodesViewModelType> {
    @IBAction func handleEpisodeSelection(_ sender: Any) {
        viewModel.showEpisodeDetailWith(episodeId: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialDetails()
    }
    @IBOutlet weak var listHolderView: ListCollectionView!
    
    deinit {
        print("CPU can reclaim memory for \(EpisodesViewController.self) - No Retail Cycle/Leak")
    }
}

extension EpisodesViewController: EpisodesViewModelConsumer {
    func setEpisodess(episodesList: Episodes) {
        title = viewModel.title
        listHolderView.createAndBindCollectionView(with: .init(cellType: EpisodesSectionHandler(),
                                                               data: episodesList as [AnyObject]),
                                                   layout: .listLayout,
                                                   handleSelection: { [weak self] tappedIndex in
                                                        self?.viewModel.showEpisodeDetailWith(episodeId: episodesList[tappedIndex].episodeID)
                                                   })
    }
}
