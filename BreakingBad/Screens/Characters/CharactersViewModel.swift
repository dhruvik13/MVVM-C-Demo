//
//  CharactersViewModel.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

protocol CharactersViewModelConsumer: AnyObject {
    func setCharacters(characterList: Characters, layout: ListCollectionView.FlowLayoutType)
}

class CharactersViewModel: CharactersViewModelType {
    
    struct Actions {
        let showSingleCharacterDetail: (Int) -> Void
    }
    
    var title: String = "Characters"
    
    private weak var consumer: CharactersViewModelConsumer?
    private var actionHandler: Actions
    private var seriesCharacters: Characters
    private var characterDetailProvider: CharactersProvider
    
    init(consumer: CharactersViewModelConsumer?,
         seriesCharacters: Characters,
         action: Actions,
         characterDetailProvider: CharactersProvider = CharactersFetchInteractor()) {
        self.consumer = consumer
        self.seriesCharacters = seriesCharacters
        self.characterDetailProvider = characterDetailProvider
        self.actionHandler = action
    }
    
    func setCharactersListWith(_ layout: ListCollectionView.FlowLayoutType) {
        consumer?.setCharacters(characterList: seriesCharacters, layout: layout)
    }
    
    func getCharactersRowsCount() -> Int {
        guard !seriesCharacters.isEmpty else { return 0 }
        return seriesCharacters.count
    }
    
    func showCharacterDetailWith(characterId: Int) {
        actionHandler.showSingleCharacterDetail(characterId)
    }
}
