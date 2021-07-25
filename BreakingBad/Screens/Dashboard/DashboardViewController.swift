//
//  DashboardViewController.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import UIKit

protocol DashboardViewModelType {
    var title: String { get set }
    func getDataCount() -> Int
    func getCellDataAt(index: Int) -> DashboardScreenStaticInfo
    func handleAction(index: Int)
}

class DashboardViewController: BaseViewController<DashboardViewModelType> {
        
    var dashboardCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        setUpCollectionView()
    }
    
    // MARK: - CollectionView
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width-2, height: view.frame.size.height/3)
        
        dashboardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dashboardCollectionView?.backgroundColor = .clear
        
        guard let dashboardCollectionView = dashboardCollectionView else { return }
        dashboardCollectionView.register(DashboardCell.self, forCellWithReuseIdentifier: DashboardCell.identifier)
        
        dashboardCollectionView.delegate = self
        dashboardCollectionView.dataSource = self
        
        view.addSubview(dashboardCollectionView)
        dashboardCollectionView.frame = view.bounds
    }
}

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        cell.configure(with: viewModel.getCellDataAt(index: indexPath.row))
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.handleAction(index: indexPath.row)
    }
}

extension DashboardViewController: DashboardLandingConsumer {
    func setScreenDetails(details: [DashboardScreenStaticInfo]) {
        
    }
}
