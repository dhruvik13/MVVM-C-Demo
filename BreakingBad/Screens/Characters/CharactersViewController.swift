//
//  CharactersViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 20/07/2021.
//

import UIKit

protocol CharactersViewModelType {
    var title: String { get set }
    func setCharactersListWith(_ layout: ListCollectionView.FlowLayoutType)
    func showCharacterDetailWith(characterId: Int)
}

class CharactersViewController: BaseViewController<CharactersViewModelType> {
    var breakingBadCharacterList: Characters = []
    @IBOutlet weak var listHolderView: ListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        viewModel.setCharactersListWith(.smallTileLayout)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "largeTileLayout"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeLayout))
    }
    
    @objc
    func changeLayout() {
        if listHolderView.currentFlowLayout == .largeTileLayout {
            listHolderView.changeLayout(layout: .smallTileLayout)
            navigationItem.rightBarButtonItem?.image = UIImage(named: "largeTileLayout")
        } else {
            listHolderView.changeLayout(layout: .largeTileLayout)
            navigationItem.rightBarButtonItem?.image = UIImage(named: "smallTileLayout")
        }
    }
    
    @IBAction func handleCharacterSelection(_ sender: Any) {
        viewModel.showCharacterDetailWith(characterId: 1)
    }
    
    deinit {
        print("CPU can reclaim memory for \(CharactersViewController.self) - No Retail Cycle/Leak")
    }
}

extension CharactersViewController: CharactersViewModelConsumer {
    func setCharacters(characterList: Characters, layout: ListCollectionView.FlowLayoutType) {
        listHolderView.createAndBindCollectionView(with: .init(cellType: CharacterSectionHandler(),
                                                               data: characterList as [AnyObject]),
                                                   layout: layout,
                                                   handleSelection: { [weak self] tappedIndex in
                                                        self?.viewModel.showCharacterDetailWith(characterId: characterList[tappedIndex].charID)
                                                   })
    }
}
