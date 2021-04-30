//
//  VideoViewController.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 28.04.2021.
//

import UIKit

protocol VideoViewControllerProtocol: BaseViewControllerProtocol {

}

class VideoViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var presenter: VideoPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = VideoPresenter(view: self)
        
        setupViews()
    }
    
    // MARK: - UI
    private func setupViews() {
        configurateSliderView()
        configurateTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configurateNavigationTabBar()
    }
    
    private func configurateTableView() {
        tableView.dataSource = self
        tableView.register(VideoTableViewCell.self)
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

extension VideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.create(VideoTableViewCell.self, indexPath)
       return cell
    }

}

extension VideoViewController: VideoViewControllerProtocol {

}
