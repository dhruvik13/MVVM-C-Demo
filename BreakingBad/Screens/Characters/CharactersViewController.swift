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
    func getCharactersRowsCount() -> Int
    func showCharacterDetailWith(characterId: Int)
}

class CharactersViewController: BaseViewController<CharactersViewModelType> {
    var breakingBadCharacterList: Characters = []
    @IBOutlet weak var listHolderView: ListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        viewModel.setCharactersListWith(.largeTileLayout)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "largeTileLayout"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeLayout))
    }
    
    @objc
    func changeLayout() {
        if listHolderView.currentFlowLayout == .largeTileLayout {
            viewModel.setCharactersListWith(.smallTileLayout)
            navigationItem.rightBarButtonItem?.image = UIImage(named: "smallTileLayout")
        } else {
            viewModel.setCharactersListWith(.largeTileLayout)
            navigationItem.rightBarButtonItem?.image = UIImage(named: "largeTileLayout")
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            if let indexPath = self.listHolderView.collectionView?.indexPathForItem(at: CGPoint(x: 0, y: 0)) {
                self.listHolderView.collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
            }
        })
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
