//
//  TransformationCollectionViewCell.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 1/3/24.
//

import UIKit

final class TransformationCollectionViewCell: UICollectionViewCell {


    //MARK: - Identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var transformationImage: UIImageView!
    @IBOutlet weak var transformationLabel: UILabel!
    
    //MARK: - Configure
    func configureWith(transformation: NSMTransformations) {
        transformationLabel.text = transformation.name
        guard let imageURL = URL(string: transformation.photo ?? "") else {
            return
        }
        transformationImage.setImage(url: imageURL)
    }
}
