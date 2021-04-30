//
//  SelectedMoviesPresenter.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import Foundation

protocol SelectedMoviesPresenterProtocol {
    init(view: SelectedMoviesViewControllerProtocol, selectedMovie: Movie)
    func configurateView()
}

class SelectedMoviesPresenter: SelectedMoviesPresenterProtocol {
    
    private unowned let view: SelectedMoviesViewControllerProtocol
    
    required init(view: SelectedMoviesViewControllerProtocol, selectedMovie: Movie) {
        self.view = view
        self.selectedMovie = selectedMovie
    }
    
    //MARK: Properties
    private let selectedMovie: Movie
    
    // MARK: - UI
    func configurateView() {
        
        self.view.display(selectedMovie:
                            SelectedMoviesViewController.selectedMovieModel(movieImage: MovieRequests.imagePath + selectedMovie.backdropPath,
                                                                            movieName: selectedMovie.title,
                                                                            originalMovieName: selectedMovie.originalTitle,
                                                                            overView: selectedMovie.overview,
                                                                            releaseData: selectedMovie.releaseDate,
                                                                            voteAverage: selectedMovie.voteAverage,
                                                                            voteCount: selectedMovie.voteCount,
                                                                            popularity: selectedMovie.popularity))
    }
    
}
