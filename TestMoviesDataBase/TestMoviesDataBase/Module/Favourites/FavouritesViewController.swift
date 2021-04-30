//
//  FavouritesViewController.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import UIKit

protocol FavouritesViewControllerProtocol: BaseViewControllerProtocol {

}

class FavouritesViewController: UIViewController {
        
    // MARK: - IBOutlet
    @IBOutlet weak var sliderView: UIView!
    
    // MARK: - Properties
    var presenter: FavouritesPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FavouritesPresenter(view: self)
    
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configurateNavigationTabBar()
    }
    
    // MARK: - UI
    
    private func setupViews() {
        configurateSliderView()
      
    }

    private func configurateSliderView() {
        let slider : CustomSliderView = .fromNib()
        sliderView.addSubview(slider)
        sliderView.constrainToEdges(slider)
    }
    
    private func configurateNavigationTabBar() {
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - IBActions
    
}

extension FavouritesViewController: FavouritesViewControllerProtocol {

}
