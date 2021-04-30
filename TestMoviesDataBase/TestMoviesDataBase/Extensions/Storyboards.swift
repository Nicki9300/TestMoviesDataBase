//
//  Storyboards.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard {
        case stories
        case selectedMovie
        case video
        case favourites
        case search

        
        var title: String {
            return String(describing: self).firstUppercased
        }
    }
    
    convenience init(storyboard: Storyboard) {
        self.init(name: storyboard.title, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T {
        let id = NSStringFromClass(T.self).components(separatedBy: ".").last!
        return self.instantiateViewController(withIdentifier: id) as! T
    }
}
