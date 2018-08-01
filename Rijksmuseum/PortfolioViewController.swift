
import UIKit

protocol PortfolioViewControllerInterface: class{
    var viewModel:Portfolio.FetchListings.ViewModel{get set}
}

class PortfolioViewController: UIViewController, PortfolioViewControllerInterface{
    let interactor: PortfolioInteractorInterface
    let router: PortfolioRouterInterface
    convenience init(interactor: PortfolioInteractorInterface,
         router: PortfolioRouterInterface){
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        self.init
    }

    let rootView = PortfolioView()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Rijksmuseum"
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
        interactor.fetchListings(request: Portfolio.FetchListings.Request())
    }

    var viewModel = Portfolio.FetchListings.ViewModel(viewState: .loading,
                                                      highlightedIndex: nil) {
        willSet{willUpdateViewModel()}
        didSet{didUpdateViewModel()}
    }
}

extension PortfolioViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.numberOfListings()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.reuseIdentifier(),
                                                            for: indexPath)
        if let cell = cell as? ImageViewCell {
            cell.imageUrl = interactor.imageUrlForListingAtIndex(indexPath.row)
        }
        return cell
    }
}

extension PortfolioViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
        interactor.setHighlightedIndex(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didUnhighlightItemAt indexPath: IndexPath) {
        interactor.setHighlightedIndex(nil)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        interactor.setSelectedIndex(indexPath.row)
    }
}

extension PortfolioViewController {
    func willUpdateViewModel() {
        if let index = viewModel.highlightedIndex,
            let cell = rootView.collectionView.cellForItem(at: IndexPath(row: index, section: 0)){
                cell.alpha = 1.0
        }
    }

    func didUpdateViewModel(){
        switch viewModel.viewState {
        case .loading:
            break
        case .loaded(let newData):
            if newData == true {
                rootView.collectionView.reloadData()
            }
        case .error(_):
            break
        }
        if let index = viewModel.highlightedIndex,
            let cell = rootView.collectionView.cellForItem(at: IndexPath(row: index, section: 0)){
            cell.alpha = 0.5
        }
    }
}
