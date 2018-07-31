//
//  PortfolioModels.swift
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

enum Portfolio{
    enum FetchListings{
        struct Request{}
        struct Response{
            let result:Result<[ArtPrimitive], Error>
        }
        struct ViewModel{
            enum ViewState {
                case loading
                case loaded
                case error(String)
            }
            let viewState:ViewState
        }
    }

    static func build()->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let artPrimitiveAPI = ArtPrimitiveAPI()
        let router = PortfolioRouter()
        let artPrimitiveWorker = ArtPrimitiveWorker(artPrimitiveSource: artPrimitiveAPI)
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artPrimitiveWorker: artPrimitiveWorker)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
