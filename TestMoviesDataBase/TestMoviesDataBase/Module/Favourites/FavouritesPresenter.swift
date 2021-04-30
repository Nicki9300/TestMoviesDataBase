//
//  FavouritesPresenter.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import Foundation

protocol FavouritesPresenterProtocol {
    init(view: FavouritesViewControllerProtocol)
}

class FavouritesPresenter: FavouritesPresenterProtocol {
    
    private unowned let view: FavouritesViewControllerProtocol

    required init(view: FavouritesViewControllerProtocol) {
        self.view = view
    }
    
}
