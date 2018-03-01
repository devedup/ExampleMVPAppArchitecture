//
//  ScorePresenter.swift
//  CSExample
//
//  Created by David Casserly on 26/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation


/// To decouple the VC from the Presenter
/// We declare we're conforming to ActivityIndicatorPresentable and ErrorPresentable so that out presenter can use activity indicators and display errors on this VC
protocol ScorePresenterView: class, ActivityIndicatorPresentable, ErrorPresentable {
    
    func present(scoreData: ScoreViewModel)
    
}

final class ScorePresenter {
    
    /// Weak because the VC has strong ref on the Presenter, avoiding circular ref cycle
    weak private var view: ScorePresenterView?
    private let service: ScoreService
    
    /// Create a score presenter. The service will default to DefaultScoreService.
    ///
    /// - Parameters:
    ///   - view: the view delegate, usually your ViewController, or a test double
    ///   - service: the score service, or your test double
    init(view: ScorePresenterView, service: ScoreService = DefaultScoreService()) {
        self.view = view
        self.service = service
    }
    
    /// Trigger the loading of the score data, which will return asynchronously and call presentScoreData when it is complete, or it may present an error
    func loadScoreData() {
        view?.presentActivityIndicator()
        service.loadScoreData { [weak self] (scoreServiceResult) in
            switch scoreServiceResult {
            case .success(let scoreModel):
                // I prefer to present a ViewModel rather than the Model classes, again for the decoupling of the layers and only place in the ViewModel what would be displayed to the user
                let viewModel = ScoreViewModel(scoreModel)
                self?.view?.present(scoreData: viewModel)
            case .failure(let error):
                // The error could be transformed into something more displayable
                self?.view?.present(error)
            }
            self?.view?.dismissActivityIndicator()
        }
    }
    
}
