//
//  CharactersViewModelTests.swift
//  BreakingBadTests
//
//  Created by dhruvik.rao on 25/07/2021.
//

import XCTest
@testable import BreakingBad

class CharactersViewModelTests: XCTestCase {
    var dummyCharacters: Characters = [.init(charID: 1,
                                             name: "Name",
                                             birthday: "birthday",
                                             occupation: ["Occupation"],
                                             img: "imageURL",
                                             status: .alive,
                                             nickname: "nickName",
                                             appearance: [1, 2, 4],
                                             portrayed: "portrayed",
                                             category: "category",
                                             betterCallSaulAppearance: []),
                                       .init(charID: 2,
                                             name: "Name",
                                             birthday: "birthday",
                                             occupation: ["Occupation"],
                                             img: "imageURL",
                                             status: .alive,
                                             nickname: "nickName",
                                             appearance: [1, 2],
                                             portrayed: "portrayed",
                                             category: "category",
                                             betterCallSaulAppearance: [])]
    
    private func makeSUT(consumer: SpyConsumer = SpyConsumer(), _ spy: ActionHandlerSpy = .init()) -> CharactersViewModel {
        let viewModel = CharactersViewModel(consumer: consumer,
                                            seriesCharacters: dummyCharacters,
                                            action: .init(showSingleCharacterDetail: spy.showCharacterDetail(characterId:)))
        return viewModel
    }
    
    private class SpyConsumer: CharactersViewModelConsumer {
        var charactersList: Characters = []
        func setCharacters(characterList: Characters, layout: ListCollectionView.FlowLayoutType) {
            self.charactersList = characterList
        }
    }
    
    func testSetCharacters() {
        let spyConsumer = SpyConsumer()
        let spyHandler = ActionHandlerSpy()
        let viewModel = makeSUT(consumer: spyConsumer, spyHandler)
        XCTAssertEqual(viewModel.title, "Characters")
        viewModel.setCharactersListWith(.largeTileLayout)
        XCTAssertEqual(spyConsumer.charactersList, dummyCharacters)
    }
    
    func testShowCharacterDetailWith() {
        let spyHandler = ActionHandlerSpy()
        let viewModel = makeSUT(spyHandler)
        XCTAssertNil(spyHandler.characterId)
        XCTAssertEqual(spyHandler.openCharactersDetailCount, 0)
        viewModel.showCharacterDetailWith(characterId: 1)
        XCTAssertEqual(spyHandler.characterId, 1)
        XCTAssertEqual(spyHandler.openCharactersDetailCount, 1)
    }
    
    private class ActionHandlerSpy {
        var openCharactersDetailCount: Int = 0
        var characterId: Int?
        func showCharacterDetail(characterId: Int) {
            self.characterId = characterId
            openCharactersDetailCount += 1
        }
    }
}
