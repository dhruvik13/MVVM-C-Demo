//
//  QuotesCell.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 23/07/2021.
//

import UIKit

class QuotesCell: UICollectionViewCell {
    static let identifier = "QuotesCell"
    
    let quoteText: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .topLeft
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quoteBy: UILabel = {
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
        contentView.addSubview(quoteText)
        contentView.addSubview(quoteBy)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            quoteText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            quoteText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            quoteText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            //
            quoteBy.leadingAnchor.constraint(equalTo: quoteText.leadingAnchor),
            quoteBy.topAnchor.constraint(equalTo: quoteText.bottomAnchor, constant: 10),
            quoteBy.trailingAnchor.constraint(equalTo: quoteText.trailingAnchor),
            quoteBy.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with quote: Quote) {
        quoteText.text = quote.quote
        quoteBy.text = String("-- by \(quote.author)")
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
