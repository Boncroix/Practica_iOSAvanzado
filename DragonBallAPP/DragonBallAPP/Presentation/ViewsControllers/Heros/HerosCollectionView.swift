//
//  HomeVC.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 24/2/24.
//

import UIKit

final class HerosCollectionView: UIViewController {
    
    private var viewModel: HerosViewModel
    
    init(viewModel: HerosViewModel = HerosViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HerosCollectionView.self),
                   bundle: nil)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarWithLogout()
    }
}
