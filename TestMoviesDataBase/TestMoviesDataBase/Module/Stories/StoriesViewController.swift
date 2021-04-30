//
//  StoriesViewController.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import UIKit

protocol BaseViewControllerProtocol : class {
    func pushToVC(_ vc: UIViewController, animated: Bool)
}

protocol StoriesViewControllerProtocol: BaseViewControllerProtocol {
    func stopActivityIndicator()
    func reloadTableView()
}

class StoriesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sliderView: UIView!
    
    // MARK: - Properties
    var presenter: StoriesPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = StoriesPresenter(view: self)
        presenter.getMovies()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configurateNavigationTabBar()
        configurateSliderView()
    }
    
    // MARK: - UI
    private func setupViews() {
        configurateTableView()
        
    }
    
    private func configurateSliderView() {
        let slider : CustomSliderView = .fromNib()
        sliderView.addSubview(slider)
        sliderView.constrainToEdges(slider)
    }
    
    private func configurateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self)
        tableView.register(AnimationTableViewCell.self)
    }
    
    private func configurateNavigationTabBar() {
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - IBActions
    @IBAction func tappedSearch(_ sender: UIBarButtonItem) {
        presenter.tappedSearch()
    }
    
}

extension StoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= presenter.getCountItemMovie() - 1 {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            presenter.paginationScroll()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.pressedMovieCell(item: indexPath.row)
    }
    
}

extension StoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCountItemMovie()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.create(AnimationTableViewCell.self, indexPath)
            presenter.configurateAnimationTableViewCell(cell: cell)
            return cell
        }
        else {
            let cell = tableView.create(MovieTableViewCell.self, indexPath)
            presenter.configutateMovieTableViewCell(cell: cell, item: indexPath.row)

            return cell
        }
    }  
}

extension StoriesViewController: StoriesViewControllerProtocol {
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
