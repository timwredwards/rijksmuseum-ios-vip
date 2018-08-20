
import UIKit
import TinyConstraints

class PortfolioView: UIView{
    let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewLayout())
    let refreshControl = UIRefreshControl()
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {fatalError()}

    func setupSubviews(){
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.alwaysBounceVertical = true
        collectionView.register(ImageViewCell.self,
                                forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier())
        addSubview(collectionView)
        collectionView.edges(to: self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let flowLayout = UICollectionViewFlowLayout()
        let gutterSize = CGFloat(8)
        let cellSize = CGFloat(83.75)
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        flowLayout.minimumLineSpacing = CGFloat(gutterSize)
        flowLayout.minimumInteritemSpacing = CGFloat(gutterSize)
        flowLayout.sectionInset = UIEdgeInsets(top: gutterSize,
                                               left: gutterSize,
                                               bottom: gutterSize,
                                               right: gutterSize)
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
}
