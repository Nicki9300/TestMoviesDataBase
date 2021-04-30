//
//  AnimationCollectionViewCell.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import UIKit
import SDWebImage

protocol AnimationCollectionViewCellProtocol {
    func configurateCollectionViewCell(with title: String, withUrl image: String)
}

class AnimationCollectionViewCell: UICollectionViewCell {
    
     // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
     // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
}

extension AnimationCollectionViewCell: AnimationCollectionViewCellProtocol {
    func configurateCollectionViewCell(with title: String, withUrl image: String) {
        imageView.sd_setImage(with: URL(string: image))
        titleLabel.text = title
    }
}
