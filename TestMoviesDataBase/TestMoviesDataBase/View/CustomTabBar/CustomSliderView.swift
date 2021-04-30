//
//  SliderView.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import UIKit

protocol SliderViewProtocol: class {
    func selectItem(_ item: SliderItem)
}

enum SliderItem: Int, CaseIterable {
    case stories = 0
    case video
    case favourites
}

class SelectedSliderItem {
    
    static let shared = SelectedSliderItem()
    private init() {}
    var selectedSlideItem: SliderItem = .stories
}

class CustomSliderView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var storiesView: UIView!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var sliderItem: SliderItem = SelectedSliderItem.shared.selectedSlideItem
    private var sliderItemCount = CGFloat(SliderItem.allCases.count)
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
        configurateCollectionView()
    }
    
    // MARK: - UI
    private func resetContent() {
        
    }
    
    private func setupView() {
        configurateStoriesItem()
        configurateVideoItem()
        configurateFavoritesItem()
    }
    
    private func configurateCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TabBarCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TabBarCollectionViewCell.identifier)
        
    }
    
    private func configurateStoriesItem() {
        storiesLabel.text = "Stories".uppercased()
        if sliderItem == .stories {
            storiesLabel.font = UIFont(name: "Malayalam Sangam MN Bold", size: 20)
            storiesLabel.textColor = .white
            storiesView.isHidden = false
        } else {
            storiesLabel.textColor = .lightGray
            storiesLabel.font = UIFont(name: "Malayalam Sangam MN", size: 20)
            storiesView.isHidden = true
        }
    }
    
    private func configurateVideoItem() {
        videoLabel.text = "Video".uppercased()
        if sliderItem == .video {
            videoLabel.font = UIFont(name: "Malayalam Sangam MN Bold", size: 20)
            videoLabel.textColor = .white
            videoView.isHidden = false
        } else {
            videoLabel.textColor = .lightGray
            videoLabel.font = UIFont(name: "Malayalam Sangam MN", size: 20)
            videoView.isHidden = true
        }
    }
    
    private func configurateFavoritesItem() {
        favoritesLabel.text = "favorites".uppercased()
        if sliderItem == .favourites {
            favoritesLabel.font = UIFont(name: "Malayalam Sangam MN Bold", size: 20)
            favoritesLabel.textColor = .white
            favoritesView.isHidden = false
        } else {
            favoritesLabel.textColor = .lightGray
            favoritesLabel.font = UIFont(name: "Malayalam Sangam MN", size: 20)
            favoritesView.isHidden = true
        }
    }
}

extension CustomSliderView: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var itemNumber = Int(round((scrollView.contentOffset.x) / (scrollView.frame.width)))
        
        switch sliderItem {
        case .stories :
            itemNumber = sliderItem.rawValue + 1
        case .video:
            itemNumber = scrollView.contentOffset.x > 0 ? sliderItem.rawValue + 1 : sliderItem.rawValue - 1
        case .favourites:
            itemNumber = sliderItem.rawValue - 1
        }
        
        switch itemNumber {
        case 0:
            SelectedSliderItem.shared.selectedSlideItem = .stories
            setupView()
            if let parent = self.parentViewController {
                let vc = StoriesViewController.instance(.stories)
                vc.presenter = StoriesPresenter(view: vc)
                parent.pushToVC(vc, animated: false)
            }
        case 1:
            SelectedSliderItem.shared.selectedSlideItem = .video
            setupView()
            if let parent = self.parentViewController {
                let vc = VideoViewController.instance(.video)
                vc.presenter = VideoPresenter(view: vc)
                parent.pushToVC(vc, animated: false)
            }
        case 2:
            SelectedSliderItem.shared.selectedSlideItem = .favourites
            setupView()
            if let parent = self.parentViewController {
                let vc = FavouritesViewController.instance(.favourites)
                vc.presenter = FavouritesPresenter(view: vc)
                parent.pushToVC(vc, animated: false)
            }
        default:
            return
        }
        
    }
}

extension CustomSliderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SliderItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionViewCell.identifier, for: indexPath) as! TabBarCollectionViewCell
        return cell
    }
}

extension CustomSliderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
}

extension CustomSliderView: SliderViewProtocol {
    
    func selectItem(_ item: SliderItem) {
        sliderItem = item
        setupView()
    }
}
