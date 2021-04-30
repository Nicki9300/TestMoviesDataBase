//
//  ViewController.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slidesView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var labegl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let customSlidesView: SliderView = .fromNib()
        slidesView.addSubview(customSlidesView)
        slidesView.constrainToEdges(customSlidesView)
  
    }
    
    @IBAction func pageControl(_ sender: UIPageControl) {
        print(pageControl.currentPage)
    }

    
}
