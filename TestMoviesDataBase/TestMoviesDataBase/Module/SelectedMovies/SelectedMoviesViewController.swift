//
//  SelectedMoviesViewController.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import UIKit
import SDWebImage

protocol SelectedMoviesViewControllerProtocol: BaseViewControllerProtocol {
    func display(selectedMovie: SelectedMoviesViewController.selectedMovieModel)
}

class SelectedMoviesViewController: UIViewController {
    
    struct selectedMovieModel {
        let movieImage: String
        let movieName: String
        let originalMovieName: String
        let overView: String
        let releaseData: String
        let voteAverage: Double
        let voteCount: Int
        let popularity: Double
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var originalMovieNameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    // MARK: - Properties
    var presenter: SelectedMoviesPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - UI
    private func setupViews() {
        presenter.configurateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - IBActions
    
}

extension SelectedMoviesViewController: SelectedMoviesViewControllerProtocol {
    
    func display(selectedMovie: selectedMovieModel) {
        movieImageView.sd_setImage(with: URL(string: selectedMovie.movieImage))
        movieNameLabel.text = selectedMovie.movieName
        originalMovieNameLabel.text = selectedMovie.originalMovieName
        overViewLabel.text = selectedMovie.overView
        releaseDataLabel.text = selectedMovie.releaseData
        voteAverageLabel.text = String(selectedMovie.voteAverage)
        voteCountLabel.text = String(selectedMovie.voteCount)
        popularityLabel.text = String(selectedMovie.popularity)
    }
}
