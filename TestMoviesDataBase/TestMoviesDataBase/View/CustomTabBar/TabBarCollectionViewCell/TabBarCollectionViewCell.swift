//
//  TabBarCollectionViewCell.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import UIKit

protocol TabBarCollectionViewCellProtocol {

}

class TabBarCollectionViewCell: UICollectionViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetContent()
    }
     
    private func resetContent() {

    }
    
    private func setupView() {
        
    }
    
}

extension TabBarCollectionViewCell: TabBarCollectionViewCellProtocol {
    
   
}
