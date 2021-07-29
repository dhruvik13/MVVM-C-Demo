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
    
    enum CollectionDatasource {
        case Characters
        case Episodes
        case Quotes
    }
    
    private var handleDidSelect: ((IndexPath) -> Void)?
    var cellModel: CellModel?
    let sectionContainer: SectionContainer = SectionContainer(handlers: [CharacterSectionHandler(),
                                                                         EpisodesSectionHandler(),
                                                                         QuotesSectionHandler()])
    @IBOutlet weak var collectionView: UICollectionView!
    var currentFlowLayout: FlowLayoutType = .largeTileLayout
    var currentCollectionDatasource: CollectionDatasource = .Characters
    
    public init(with frame: CGRect = .zero) {
        super.init(frame: frame)
        loadViewFromNib(bundle: Bundle.main)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(bundle: Bundle.main)
    }
    
    public func createAndBindCollectionView(with cellModel: CellModel,
                                            layout: FlowLayoutType,
                                            bindCollectionFor: CollectionDatasource,
                                            handleSelection: @escaping (IndexPath) -> Void) {
        self.cellModel = cellModel
        currentCollectionDatasource = bindCollectionFor
        handleDidSelect = handleSelection
        currentFlowLayout = layout
        setUpCollectionView()
    }
    
    public func changeLayout(layout: FlowLayoutType) {
        currentFlowLayout = layout
        collectionView.setContentOffset(.zero, animated: true)
        collectionView.reloadData()
    }
    
    // MARK: - CollectionView
    private func setUpCollectionView() {
        // Resgister Collectionview with all availabe custom cells
        switch currentCollectionDatasource {
        case .Characters:
            collectionView.register(CharactersCell.self,
                                    forCellWithReuseIdentifier: CharactersCell.identifier)
        case .Episodes:
            collectionView.register(EpisodesCell.self,
                                    forCellWithReuseIdentifier: EpisodesCell.identifier)
        case .Quotes:
            collectionView.register(QuotesCell.self,
                                    forCellWithReuseIdentifier: QuotesCell.identifier)
        }
        
        collectionView.register(HeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderReusableView.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self

        setUpFlowLayout()
    }
    
    private func setUpFlowLayout() {
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
        if currentCollectionDatasource == .Episodes {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
        return CGSize(width: 0, height: layoutComponent.minimumLineSpacing)
    }
}

extension ListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDidSelect?(indexPath)
    }
}

extension ListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: HeaderReusableView.identifier,
                                                                         for: indexPath) as! HeaderReusableView
            switch currentCollectionDatasource {
            case .Episodes:
                guard let episode = cellModel?.sectionContent?[indexPath.section][indexPath.section] as? Episode else {
                    return header
                }
                header.configure(with: "Series #\(episode.season)" )
            default:
                header.configure(with: "")
            }
            return header
        default:
            return UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: layoutComponent.minimumLineSpacing))
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellModel?.sectionContent?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = cellModel?.data {
            return data.count
        } else {
            return cellModel?.sectionContent?[section].count ?? 0
        }
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
