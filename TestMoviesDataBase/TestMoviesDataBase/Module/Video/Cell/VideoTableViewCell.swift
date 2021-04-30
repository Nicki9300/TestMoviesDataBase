//
//  VideoTableViewCell.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 29.04.2021.
//

import UIKit

protocol VideoTableViewCellProtocol {

}

class VideoTableViewCell: UITableViewCell {
    
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

extension VideoTableViewCell: VideoTableViewCellProtocol {

}
