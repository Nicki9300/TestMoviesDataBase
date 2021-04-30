//
//  StoriesPresenter.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import Foundation

protocol StoriesPresenterProtocol {
    init(view: StoriesViewControllerProtocol)
    func configutateMovieTableViewCell(cell: MovieTableViewCellProtocol, item: Int) 
    func getMovies()
    func getCountItemMovie() -> Int
    func pressedMovieCell(item: Int)
    func paginationScroll()
    func configurateAnimationTableViewCell(cell: AnimationTableViewCellProtocol)
    func tappedSearch()
}

class StoriesPresenter: StoriesPresenterProtocol {
    
    private unowned let view: StoriesViewControllerProtocol
    
    required init(view: StoriesViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: - Properties
    private var responce: ResultMovies = ResultMovies(page: 0, results: [], totalPages: 0, totalResults: 0)
    private var arrayOfMovie: [Movie] = []
    private var currentPage = 1
    private var profile = MoviesApi()
    
    // MARK: - UI
    func configutateMovieTableViewCell(cell: MovieTableViewCellProtocol, item: Int) {
        cell.display(movieModel:
                        MovieTableViewCell.MovieModel(title: arrayOfMovie[item].title,
                                                      originalTitle: arrayOfMovie[item].originalTitle,
                                                      releaseData: arrayOfMovie[item].releaseDate,
                                                      originalLanguage: arrayOfMovie[item].originalLanguage,
                                                      voteAverage: arrayOfMovie[item].voteAverage,
                                                      VoteCount: arrayOfMovie[item].voteCount,
                                                      movieImage: MovieRequests.imagePath + arrayOfMovie[item].backdropPath))
    }
    
    func configurateAnimationTableViewCell(cell: AnimationTableViewCellProtocol) {
        
        let topFiveMovies = 5
        let topMoviesArray = getTopMovie(countMovie: topFiveMovies)
        var arrayOfTopFiveTitles: [String] = []
        var arrayOfTopFiveImage : [String] = []
        for movie in topMoviesArray {
            arrayOfTopFiveTitles.append(movie.originalTitle)
            arrayOfTopFiveImage.append(movie.backdropPath)
        }
        cell.diplayCollectionViewCell(title: arrayOfTopFiveTitles, with: arrayOfTopFiveImage, forTotalPage: topFiveMovies)
    }
    
    // MARK: - Actions
    func getCountItemMovie() -> Int {
        return arrayOfMovie.count
    }
    
    func getTopMovie(countMovie : Int) -> [Movie] {
        var countMovie = countMovie
        countMovie = countMovie > arrayOfMovie.count ? arrayOfMovie.count : countMovie
        var topArray = responce.results.sorted { $0.voteAverage > $1.voteAverage }
        
        if arrayOfMovie.count - countMovie > topArray.count {
            topArray.removeLast(topArray.count - countMovie)
        }
        else {
            topArray.removeLast(arrayOfMovie.count - countMovie)
        }
        return topArray
       
    }
    
    func pressedMovieCell(item: Int) {
        let vc = SelectedMoviesViewController.instance(.selectedMovie)
        vc.presenter = SelectedMoviesPresenter(view: vc, selectedMovie: self.arrayOfMovie[item])
        self.view.pushToVC(vc, animated: true)
    }
    
    func tappedSearch() {
        let vc = SearchViewController.instance(.search)
        vc.movies = arrayOfMovie
        self.view.pushToVC(vc, animated: true)
    }
    
    func paginationScroll() {
        if currentPage <= responce.totalPages {
            currentPage += 1
            self.getMovies()
        } else {
            self.view.stopActivityIndicator()
        }
    }
    
    // MARK: - API
    func getMovies() {
        profile.fetchMovies(withPage: currentPage) { [self] (responce, error) in
            profile.fetchMovies(withPage: self.currentPage) { (responce, error) in
                if let responce = responce as? ResultMovies {
                    self.arrayOfMovie.append(contentsOf: responce.results)
                    self.responce = responce
                    self.view.reloadTableView()
                    self.view.stopActivityIndicator()
                } else {
                    self.view.stopActivityIndicator()
                    if let error = error {
                        print("Error", error.localizedDescription)
                    } else {
                        print("No parsing")
                    }
                }
            }
            
        }
    }
}
