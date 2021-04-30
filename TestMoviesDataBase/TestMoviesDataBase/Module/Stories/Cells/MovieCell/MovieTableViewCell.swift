//
//  MovieTableViewCell.swift
//  Regusts
//
//  Created by Коля Мамчур on 19.04.2021.
//

import UIKit
import SDWebImage

protocol MovieTableViewCellProtocol {
    func display(movieModel: MovieTableViewCell.MovieModel)
}

class MovieTableViewCell: UITableViewCell {
    
    struct MovieModel {
        let title: String
        let originalTitle: String
        let releaseData: String
        let originalLanguage: String
        let voteAverage: Double
        let VoteCount: Int
        let movieImage: String
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
      
        resetContent()
    }
    
    // MARK: - UI
    private func resetContent() {
        movieImageView.image = nil
        titleLabel.text = nil
        originalTitleLabel.text = nil
        releaseDataLabel.text = nil
        originalLanguageLabel.text = nil
        voteAverageLabel.text = nil
        voteCountLabel.text = nil
    }
    
    private func setupView() {
        
    }
}

extension MovieTableViewCell: MovieTableViewCellProtocol {
    
    func display(movieModel: MovieModel) {
        titleLabel.text =  movieModel.title
        originalTitleLabel.text =  movieModel.originalTitle
        releaseDataLabel.text =  movieModel.releaseData
        originalLanguageLabel.text =  movieModel.originalLanguage
        voteAverageLabel.text = String( movieModel.voteAverage)
        voteCountLabel.text = String( movieModel.VoteCount)
        movieImageView.sd_setImage(with: URL(string: movieModel.movieImage))

    }
    
}
