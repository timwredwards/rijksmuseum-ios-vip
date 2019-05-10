import UIKit
import TimKit
import MuseumKit

class Dependencies {
    let museumKitDependencies = MuseumKit.Dependencies()
}

extension Dependencies {
    func resolve() -> PortfolioViewController {
        let viewController = PortfolioViewController.from(storyboard: resolve())
        let presenter = PortfolioPresenter(display: viewController)
        let interactor = PortfolioInteractor(presenter: presenter, artService: museumKitDependencies.resolve())
        let router = PortfolioRouter(dependencies: self,
                                     dataStore: interactor,
                                     viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }

    func resolve(art: Art) -> ListingViewController {
        let viewController = ListingViewController.from(storyboard: resolve())
        let presenter = ListingPresenter(display: viewController)
        let interactor = ListingInteractor(presenter: presenter, art: art)
        viewController.interactor = interactor
        return viewController
    }
}

private extension Dependencies {

    func resolve() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
