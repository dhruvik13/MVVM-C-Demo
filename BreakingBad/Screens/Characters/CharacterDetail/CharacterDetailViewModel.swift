//
//  CharacterDetailViewModel.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import Foundation

protocol CharacterDetailViewModelConsumer: AnyObject {
    func setCharacterDetail(character: Character)
}

class CharacterDetailViewModel: CharacterDetailViewModelType {
    var title: String = ""
    
    private weak var consumer: CharacterDetailViewModelConsumer?
    private var selectedCharacter: Character
    
    init(consumer: CharacterDetailViewModelConsumer?,
         selectedCharacter: Character) {
        self.consumer = consumer
        self.selectedCharacter = selectedCharacter
        title = selectedCharacter.name
    }
    
    func setInitialDetails() {
        consumer?.setCharacterDetail(character: selectedCharacter)
    }
}
