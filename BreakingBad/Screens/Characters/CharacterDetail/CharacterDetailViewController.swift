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
    @IBOutlet private weak var blueImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setInitialDetails()
    }
    
    func addBlurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurfilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurfilter?.outputImage else { return nil }
        return UIImage(ciImage: outputImage)
    }
}

extension CharacterDetailViewController: CharacterDetailViewModelConsumer {
    func setCharacterDetail(character: Character) {
        title = viewModel.title
        let imageURL = URL(string: character.img)
        characterImageView.kf.indicatorType = .activity
        characterImageView.kf.setImage(with: imageURL) { [weak self] result in
            if let image = (try? result.get())?.image {
                self?.blueImageView.image = self?.addBlurImage(usingImage: image, blurAmount: 10.0)
                self?.blueImageView.contentMode = .scaleToFill
            }
        }
        
        characterName.text = character.name
        nickName.text = character.nickname
        characterStatus.text = character.status.rawValue
        portrayed.text = character.portrayed
        category.text = character.category
    }
}
