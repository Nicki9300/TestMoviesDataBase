//
//  VideoPresenter.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import Foundation

protocol VideoPresenterProtocol {
    init(view: VideoViewControllerProtocol)
}

class VideoPresenter: VideoPresenterProtocol {
    
    private unowned let view: VideoViewControllerProtocol

    required init(view: VideoViewControllerProtocol) {
        self.view = view
    }
    
}
