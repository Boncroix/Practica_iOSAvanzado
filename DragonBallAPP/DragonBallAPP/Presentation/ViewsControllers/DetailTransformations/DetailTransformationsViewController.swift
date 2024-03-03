//
//  DetailTransformationsViewController.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 2/3/24.
//

import UIKit

final class DetailTransformationsViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageTransformation: UIImageView!
    @IBOutlet weak var descriptionTransformation: UITextView!
    
    private var viewModel: DetailTransformationsViewModel
    
    //MARK: - Inits
    init(viewModel: DetailTransformationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: DetailTransformationsViewController.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        nameLabel.text = viewModel.transformation.name
        descriptionTransformation.text = viewModel.transformation.descrip
        guard let imageURL = URL(string: viewModel.transformation.photo ?? "") else {
            return
        }
        imageTransformation.setImage(url: imageURL)
    }
}
