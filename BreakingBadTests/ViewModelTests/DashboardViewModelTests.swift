//
//  DashboardViewModelTests.swift
//  BreakingBadTests
//
//  Created by dhruvik.rao on 25/07/2021.
//

import XCTest
@testable import BreakingBad

class DashboardViewModelTests: XCTestCase {

    let dashboardStaticInfo: [DashboardScreenStaticInfo] =
        [.init(title: "Characters", image: "characters", action: { }),
         .init(title: "Episodes", image: "episodes", action: { }),
         .init(title: "Quotes", image: "quotes", action: { })]
    
    private func makeSUT( _ spy: ActionHandlerSpy = .init()) -> DashboardViewModel {
        let viewModel = DashboardViewModel(actionHandler: .init(showCharacters: spy.openCharacters,
                                                                showEpisodes: spy.openEpisodes,
                                                                showQuotes: spy.openQuotes))
        return viewModel
    }
    
    func testGetDataCount() {
        let viewModel = makeSUT()
        XCTAssertEqual(viewModel.getDataCount(), 3)
        XCTAssertEqual(viewModel.title, "Dashboard")
    }
    
    func testGetCellDataAtIndex() {
        let viewModel = makeSUT()
        XCTAssertEqual(viewModel.getCellDataAt(index: 0).title, dashboardStaticInfo[0].title)
        XCTAssertEqual(viewModel.getCellDataAt(index: 0).image, dashboardStaticInfo[0].image)
        XCTAssertEqual(viewModel.getCellDataAt(index: 1).title, dashboardStaticInfo[1].title)
        XCTAssertEqual(viewModel.getCellDataAt(index: 1).image, dashboardStaticInfo[1].image)
        XCTAssertEqual(viewModel.getCellDataAt(index: 2).title, dashboardStaticInfo[2].title)
        XCTAssertEqual(viewModel.getCellDataAt(index: 2).image, dashboardStaticInfo[2].image)
    }
    
    func testHandleAction() {
        let spyHandler = ActionHandlerSpy()
        let viewModel = makeSUT(spyHandler)
        
        XCTAssertEqual(spyHandler.openCharactersCount, 0)
        viewModel.handleAction(index: 0)
        XCTAssertEqual(spyHandler.openCharactersCount, 1)
        
        XCTAssertEqual(spyHandler.openEpisodesCount, 0)
        viewModel.handleAction(index: 1)
        XCTAssertEqual(spyHandler.openEpisodesCount, 1)
        
        XCTAssertEqual(spyHandler.openQuotesCount, 0)
        viewModel.handleAction(index: 2)
        XCTAssertEqual(spyHandler.openQuotesCount, 1)
    }
        
    private class ActionHandlerSpy {
        var openCharactersCount: Int = 0
        func openCharacters() {
            openCharactersCount += 1
        }

        var openEpisodesCount: Int = 0
        func openEpisodes() {
            openEpisodesCount += 1
        }

        var openQuotesCount: Int = 0
        func openQuotes() {
            openQuotesCount += 1
        }
    }
}
