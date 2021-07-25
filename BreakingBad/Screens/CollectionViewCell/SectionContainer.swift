//
//  SectionContainer.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 22/07/2021.
//

import UIKit

/// Struct for CellModel
public struct CellModel {
    var cellType: SectionHandler
    var data: [AnyObject]
}

protocol SectionHandler {
    var type: String { get }
    func collectionView(cellModel: CellModel,
                        collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class SectionContainer {
    var sectionHandlers: [String: SectionHandler] = [:]
    
    init(handlers: [SectionHandler]) {
        handlers.forEach { handler in
            sectionHandlers[handler.type] = handler
        }
    }
    
    func collectionView(cellModel: CellModel,
                        collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionHandler = sectionHandlers[cellModel.cellType.type] else {
            return UICollectionViewCell()
        }
        return sectionHandler.collectionView(cellModel: cellModel, collectionView: collectionView, cellForItemAt: indexPath)
    }
}

class CharacterSectionHandler: SectionHandler {
    func collectionView(cellModel: CellModel, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCell.identifier,
                                                      for: indexPath) as! CharactersCell
        cell.configure(with: cellModel.data[indexPath.row] as! Character)
        return cell
    }
    
    var type: String {
        return "Characters"
    }
}


class EpisodesSectionHandler: SectionHandler {
    func collectionView(cellModel: CellModel, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCell.identifier,
                                                      for: indexPath) as! EpisodesCell
        cell.configure(with: cellModel.data[indexPath.row] as! Episode)
        return cell
    }
    
    var type: String {
        return "Episodes"
    }
}


class QuotesSectionHandler: SectionHandler {
    func collectionView(cellModel: CellModel, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuotesCell.identifier,
                                                      for: indexPath) as! QuotesCell
        cell.configure(with: cellModel.data[indexPath.row] as! Quote)
        return cell
    }
    
    var type: String {
        return "QuotesCell"
    }
}

