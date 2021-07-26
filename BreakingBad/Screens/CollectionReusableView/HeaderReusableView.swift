//
//  HeaderReusableView.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 26/07/2021.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    static let identifier = "HeaderReusableView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .topLeft
        return label
    }()
    
    public func configure(with title: String) {
        addSubview(titleLabel)
        titleLabel.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 12, y: 5, width: bounds.width-24, height: bounds.height-10)
    }
}
