//
//  EpisodesCell.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import UIKit

class EpisodesCell: UICollectionViewCell {
    static let identifier = "EpisodesCell"
    
    let episodeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .topLeft
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeCharacters: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .topLeft
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeAirDate: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 14.0)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemFill
        contentView.layer.cornerRadius = 8.0
        
        contentView.addSubview(episodeTitle)
        contentView.addSubview(episodeCharacters)
        contentView.addSubview(episodeAirDate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            episodeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            episodeTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            episodeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            //
            episodeCharacters.leadingAnchor.constraint(equalTo: episodeTitle.leadingAnchor, constant: 15),
            episodeCharacters.topAnchor.constraint(equalTo: episodeTitle.bottomAnchor, constant: 10),
            episodeCharacters.trailingAnchor.constraint(equalTo: episodeTitle.trailingAnchor),
            //
            episodeAirDate.leadingAnchor.constraint(equalTo: episodeCharacters.leadingAnchor),
            episodeAirDate.topAnchor.constraint(equalTo: episodeCharacters.bottomAnchor, constant: 10),
            episodeAirDate.trailingAnchor.constraint(equalTo: episodeCharacters.trailingAnchor),
            episodeAirDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(with episode: Episode) {
        episodeTitle.text = String("\(episode.episodeID). \(episode.title)")
        episodeCharacters.text = episode.characters.joined(separator: ", ")
        episodeAirDate.text = String("- aired on: \(episode.airDate)")
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

