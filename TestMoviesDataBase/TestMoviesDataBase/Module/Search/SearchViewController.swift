//
//  SearchViewController.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 29.04.2021.
//

import UIKit

protocol SearchViewControllerProtocol: BaseViewControllerProtocol {
    
}

class SearchViewController: UIViewController, SearchViewControllerProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Private Properties
    private var filterMovie : [Movie] = []
    
    // MARK: - Properties
    var movies : [Movie] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterMovie = movies
        setupViews()
        
    }
    
    // MARK: - UI
    private func setupViews() {
        configurateTableView()
        setupSearchController()
    }
    
    private func configurateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self)
    }
    
    private func setupSearchController() {
        searchBar.delegate = self
        searchBar.placeholder = "Search loaded Movie by Title (en)"
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SelectedMoviesViewController.instance(.selectedMovie)
        vc.presenter = SelectedMoviesPresenter(view: vc, selectedMovie: self.filterMovie[indexPath.row])
        self.pushToVC(vc, animated: true)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.create(SearchTableViewCell.self, indexPath)
        cell.display(with: filterMovie[indexPath.row].title, voteAverage: filterMovie[indexPath.row].voteAverage)
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterMovie = searchText.isEmpty ? movies : movies.filter({ (item: Movie) -> Bool in
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        self.tableView.reloadData()
    }
    
}
