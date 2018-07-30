//
//  PortfolioPresenter.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 29/07/2018.
//  Copyright (c) 2018 Tim Edwards. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PortfolioPresenterInterface{
    func didFetchListings(response: Portfolio.FetchListings.Response)
}

class PortfolioPresenter: PortfolioPresenterInterface{
    weak var viewController: PortfolioViewControllerInterface?

    func didFetchListings(response: Portfolio.FetchListings.Response) {
        let viewModel = Portfolio.FetchListings.ViewModel(viewState: .loaded)
        viewController?.updateViewModel(viewModel: viewModel)
    }
}
