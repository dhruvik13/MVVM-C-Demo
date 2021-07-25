//
//  EpisodesViewModelTests.swift
//  BreakingBadTests
//
//  Created by dhruvik.rao on 25/07/2021.
//

import XCTest
@testable import BreakingBad

class EpisodesViewModelTests: XCTestCase {
    let dummyEpisodes: Episodes = [.init(episodeID: 1,
                                         title: "title",
                                         season: "season",
                                         airDate: "date",
                                         characters: ["character"],
                                         episode: "episode",
                                         series: "series"),
                                   .init(episodeID: 2,
                                         title: "title",
                                         season: "season",
                                         airDate: "date",
                                         characters: ["character"],
                                         episode: "episode",
                                         series: "series")]
    
    private func makeSUT(consumer: SpyConsumer = SpyConsumer(), _ spy: ActionHandlerSpy = .init()) -> EpisodesViewModel {
        let viewModel = EpisodesViewModel(consumer: consumer,
                                          seriesEpisodes: dummyEpisodes,
                                          action: .init(showSingleEpisodeDetail: spy.showEpisodeDetail(episodeId:)) )
        return viewModel
    }
    
    private class SpyConsumer: EpisodesViewModelConsumer {
        var episodesList: Episodes = []
        func setEpisodess(episodesList: Episodes) {
            self.episodesList = episodesList
        }
    }
    
    func testSetEpisodes() {
        let spyConsumer = SpyConsumer()
        let spyHandler = ActionHandlerSpy()
        let viewModel = makeSUT(consumer: spyConsumer, spyHandler)
        XCTAssertEqual(viewModel.title, "Episodes")
        viewModel.setInitialDetails()
        XCTAssertEqual(spyConsumer.episodesList, dummyEpisodes)
    }
    
    func testshowEpisodeDetailWith() {
        let spyHandler = ActionHandlerSpy()
        let viewModel = makeSUT(spyHandler)
        XCTAssertNil(spyHandler.episodeId)
        XCTAssertEqual(spyHandler.openEpisodeDetailCount, 0)
        viewModel.showEpisodeDetailWith(episodeId: 1)
        XCTAssertEqual(spyHandler.episodeId, 1)
        XCTAssertEqual(spyHandler.openEpisodeDetailCount, 1)
    }
    
    private class ActionHandlerSpy {
        var openEpisodeDetailCount: Int = 0
        var episodeId: Int?
        func showEpisodeDetail(episodeId: Int) {
            self.episodeId = episodeId
            openEpisodeDetailCount += 1
        }
    }
}
