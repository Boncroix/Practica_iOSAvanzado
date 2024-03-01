//
//  DetailViewController.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 29/2/24.
//

import UIKit
import MapKit

final class DetailViewController: UIViewController {
    
    //MARK: - TypeAlias
    typealias DataSource = UICollectionViewDiffableDataSource<Int, NSMTransformations>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, NSMTransformations>
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loadingView: UIView!
    
    private var viewModel: DetailViewModel
    private var dataSource: DataSource?
    
    //MARK: Inits
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        setObservers()
        collectionView.delegate = self
    }
}

//MARK: - Extension
extension DetailViewController {
    //MARK: - Observers
    private func setObservers() {
        viewModel.detailViewState = { [weak self] status in
            switch status {
            case .loading(let isLoading):
                self?.loadingView.isHidden = !isLoading
            case .loaded:
                self?.setUpCollectionView()
                self?.loadingView.isHidden = true
            case .errorNetwork(let errorMessage):
                self?.loadingView.isHidden = true
                print(errorMessage)
            }
        }
    }
}

//MARK: - Delegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO
    }
}

// MARK: - setUp CollectionView
extension DetailViewController {
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        
        let registration = UICollectionView.CellRegistration<TransformationCollectionViewCell, NSMTransformations>(
            cellNib: UINib(
                nibName: TransformationCollectionViewCell.identifier,
                bundle: nil
            )
        ) { cell, _, transformation in
            cell.configureWith(transformation: transformation)
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, transformation in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: transformation
            )
        }
        
        collectionView.dataSource = dataSource
        
        DispatchQueue.main.async {
            var snapshot = Snapshot()
            snapshot.appendSections([0])
            snapshot.appendItems(self.viewModel.transformations)
            self.dataSource?.apply(snapshot)
        }
    }
}


