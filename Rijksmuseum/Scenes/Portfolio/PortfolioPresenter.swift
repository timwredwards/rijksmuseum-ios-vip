
import UIKit

// MARK: init
class PortfolioPresenter: PortfolioPresenterInterface{
    weak var viewController: PortfolioViewControllerInterface?
}

// MARK: FetchListings
extension PortfolioPresenter{
    func presentFetchListings(response: Portfolio.FetchListings.Response) {
        DispatchQueue.main.async {
            self.processFetchListingsResponse(response)
        }
    }

    private func processFetchListingsResponse(_ response:Portfolio.FetchListings.Response) {
        switch response.state {
        case .loading:
            displayFetchListings(state: .loading)
        case .loaded(let artPrimitives):
            let imageUrls = imageUrlsFrom(artPrimitives: artPrimitives)
            displayFetchListings(state: .loaded(imageUrls))
        case .error(let error):
            let errorMessage = error.localizedDescription
            displayFetchListings(state: .error(errorMessage))
        }
    }

    private func displayFetchListings(state:Portfolio.FetchListings.ViewModel.State){
        let viewModel = Portfolio.FetchListings.ViewModel(state: state)
        self.viewController?.displayFetchListings(viewModel: viewModel)
    }

    private func imageUrlsFrom(artPrimitives:[ArtPrimitive]) -> [URL] {
        return artPrimitives.map({$0.imageUrl})
    }
}
