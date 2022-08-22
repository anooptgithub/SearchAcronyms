//
//  SearchAcronymsRouter.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
import UIKit

protocol SearchAcronymsRoutable {
    func createSearchViewController() -> UIViewController
}

struct SearchAcronymsRouter: SearchAcronymsRoutable {
    
    func createSearchViewController() -> UIViewController {
        let vc: SearchAcronymsViewController = .defaultInstance()
        let interactor = SearchAcronymsInteractor(service: SearchService())
        let throttler = SearchThrottler(throttleDuration: 0.5)
        let presenter = SearchAcronymsPresenter(view: vc, interactor: interactor, throller: throttler)
        vc.presenter = presenter
        return vc
    }
}
