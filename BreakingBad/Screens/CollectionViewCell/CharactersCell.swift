//
//  CharactersCell.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 22/07/2021.
//

import UIKit
import Kingfisher

class CharactersCell: UICollectionViewCell {
    static let identifier = "CharactersCell"
    
    private let characterName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterName.frame = CGRect(x: 5,
                               y: contentView.frame.size.height-75,
                               width: contentView.frame.size.width-10,
                               height: 100)
        characterImageView.frame = contentView.frame
    }
    
    func configure(with char: Character) {
        characterName.text = char.name
        let imageURL = URL(string: char.img)
        characterImageView.kf.indicatorType = .activity
        
//        characterImageView.kf.setImage(
//            with: imageURL,
//            options: [
//                .processor(DownsamplingImageProcessor(size: characterImageView.frame.size)),
//                .scaleFactor(UIScreen.main.scale),
//                .cacheOriginalImage
//            ])
        
        characterImageView.kf.setImage(with: imageURL, options: [.fromMemoryCacheOrRefresh, .backgroundDecode])
        layoutIfNeeded()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = CGFloat(ceilf(Float(size.height)))
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
