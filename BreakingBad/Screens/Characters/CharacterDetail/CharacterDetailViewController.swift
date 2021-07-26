//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import UIKit
import Kingfisher

protocol CharacterDetailViewModelType {
    var title: String { get set }
    func setInitialDetails()
}

class CharacterDetailViewController: BaseViewController<CharacterDetailViewModelType> {
    
    @IBOutlet private weak var characterName: UILabel!
    @IBOutlet private weak var nickName: UILabel!
    @IBOutlet private weak var characterStatus: UILabel!
    @IBOutlet private weak var portrayed: UILabel!
    @IBOutlet private weak var category: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var blurImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialDetails()
    }
}

extension CharacterDetailViewController: CharacterDetailViewModelConsumer {
    func setCharacterDetail(character: Character) {
        title = viewModel.title
        let imageURL = URL(string: character.img)
        characterImageView.kf.indicatorType = .activity
        characterImageView.kf.setImage(with: imageURL) { [weak self] result in
            if let image = (try? result.get())?.image {
                self?.blurImageView.image = image
                self?.blurImageView.applyBlurEffect()
                self?.blurImageView.contentMode = .scaleToFill
            }
        }
        
        characterName.text = character.name
        nickName.text = character.nickname
        characterStatus.text = character.status.rawValue
        portrayed.text = character.portrayed
        category.text = character.category
    }
}

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
