//
//  DashboardCell.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 24/07/2021.
//

import UIKit

class DashboardCell: UICollectionViewCell {
    static let identifier = "DashboardCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.contentMode = .topRight
        return label
    }()
    
    private let contextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contextImageView)
        
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black
                            .cgColor]
        gradient.locations = [0, 0.1, 0.7, 1]
        contentView.layer.addSublayer(gradient)
        
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 5,
                               y: contentView.frame.size.height-70,
                               width: contentView.frame.size.width-10,
                               height: 100)
        contextImageView.frame = contentView.frame
    }
    
    func configure(with info: DashboardScreenStaticInfo) {
        titleLabel.text = info.title
        contextImageView.image = UIImage(named: info.image)
        layoutIfNeeded()
    }
}
