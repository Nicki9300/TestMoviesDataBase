//
//  SearchTableViewCell.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 29.04.2021.
//

import UIKit

protocol SearchTableViewCellProtocol {
    func display(with title: String, voteAverage: Double)
}

class SearchTableViewCell: UITableViewCell {

     // MARK: - IBOutlets
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
     // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension SearchTableViewCell: SearchTableViewCellProtocol {
    
    func display(with title: String, voteAverage: Double) {
        originalTitleLabel.text = title
        voteAverageLabel.text = String(voteAverage)
    }
    
}
