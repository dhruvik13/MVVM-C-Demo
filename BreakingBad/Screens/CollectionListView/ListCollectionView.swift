//
//  ListCollectionView.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 22/07/2021.
//

import UIKit

class ListCollectionView: UIView {
    
    private let layoutComponent = (minimumLineSpacing: 8.0, minimumInteritemSpacing: 4.0)
    
    enum FlowLayoutType {
        case largeTileLayout
        case smallTileLayout
        case listLayout
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var currentFlowLayout: FlowLayoutType = .largeTileLayout
    
    public init(with frame: CGRect = .zero) {
        super.init(frame: frame)
        loadViewFromNib(bundle: Bundle.main)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(bundle: Bundle.main)
    }
    
    private var handleDidSelect: ((Int) -> Void)?
    var cellModel: CellModel?
    
    let sectionContainer: SectionContainer = SectionContainer(handlers: [CharacterSectionHandler(),
                                                                         EpisodesSectionHandler(),
                                                                         QuotesSectionHandler()])
    
    public func createAndBindCollectionView(with cellModel: CellModel,
                                            layout: FlowLayoutType,
                                            handleSelection: @escaping (Int) -> Void) {
        self.cellModel = cellModel
        handleDidSelect = handleSelection
        currentFlowLayout = layout
        setUpCollectionView()
    }
    
    // MARK: - CollectionView
    private func setUpCollectionView() {
        
        // Resgister Collectionview with all availabe custom cells
        collectionView.register(CharactersCell.self,
                                forCellWithReuseIdentifier: CharactersCell.identifier)
        collectionView.register(EpisodesCell.self,
                                forCellWithReuseIdentifier: EpisodesCell.identifier)
        collectionView.register(QuotesCell.self,
                                forCellWithReuseIdentifier: QuotesCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        setUpFlowLayout()
    }
    
    func setUpFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CGFloat(layoutComponent.minimumLineSpacing)
        layout.minimumInteritemSpacing = CGFloat(layoutComponent.minimumInteritemSpacing)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension ListCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0,
                            left: CGFloat(layoutComponent.minimumLineSpacing),
                            bottom: 1.0,
                            right: CGFloat(layoutComponent.minimumLineSpacing))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // swiftlint:disable force_cast
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        switch currentFlowLayout {
        case .largeTileLayout:
            let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
            return CGSize(width: widthPerItem - CGFloat(layoutComponent.minimumLineSpacing), height: 250)
        case .smallTileLayout:
            let widthPerItem = collectionView.frame.width / 3 - lay.minimumInteritemSpacing
            return CGSize(width: widthPerItem - CGFloat(layoutComponent.minimumLineSpacing), height: widthPerItem)
        default:
            let widthPerItem = collectionView.frame.width - (lay.minimumLineSpacing * 2)
            return CGSize(width: widthPerItem - CGFloat(layoutComponent.minimumLineSpacing), height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: layoutComponent.minimumLineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: layoutComponent.minimumLineSpacing)
    }
}

extension ListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDidSelect?(indexPath.row)
    }
}

extension ListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModel?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel = cellModel else {
            return UICollectionViewCell()
        }
        let cell = sectionContainer.collectionView(cellModel: cellModel, collectionView: collectionView, cellForItemAt: indexPath)
        return cell
    }
}

public extension UIView {
   func loadViewFromNib(bundle: Bundle) {
        let nibName = "\(type(of: self))".components(separatedBy: ".").last ?? ""
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
   }
}
