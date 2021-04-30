//
//  AnimationTableViewCell.swift
//  TestMoviesDataBase
//
//  Created by Коля Мамчур on 27.04.2021.
//

import UIKit

protocol AnimationTableViewCellProtocol {
    func diplayCollectionViewCell(title: [String], with collectionImages: [String], forTotalPage pageCount: Int)
}

class AnimationTableViewCell: UITableViewCell {
    
     // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
     // MARK: - Properties
    private var collectionImages: [String] = []
    private var collectionTitle: [String] = []
    private var pageCount = 0
    
     // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetContent()
    }
     
     // MARK: - UI
    private func resetContent() {

    }
    
    private func setupView() {
        configurateCollectionView()
    }
    
    private func configurateCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: AnimationCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AnimationCollectionViewCell.identifier)
    }

}

extension AnimationTableViewCell: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
  
}

extension AnimationTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimationCollectionViewCell.identifier, for: indexPath) as! AnimationCollectionViewCellProtocol
        cell.configurateCollectionViewCell(with: collectionTitle[indexPath.row], withUrl: MovieRequests.imagePath + collectionImages[indexPath.row])
        return cell as? AnimationCollectionViewCell ?? UICollectionViewCell()
    }
    
}

extension AnimationTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
}

extension AnimationTableViewCell: AnimationTableViewCellProtocol {
    
    func diplayCollectionViewCell(title: [String], with collectionImages: [String], forTotalPage pageCount: Int) {
        self.collectionImages = collectionImages
        self.collectionTitle = title
        self.pageCount = pageCount
        pageControl.numberOfPages = collectionImages.count
    }
}
