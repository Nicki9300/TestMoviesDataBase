//
//  ViewControllerNavigationExtrnsion.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import UIKit

extension UIViewController {
       
    func pushToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
}
