//
//  ViewController.swift
//  CSExample
//
//  Created by David Casserly on 26/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import UIKit

final class ScoreViewController: UIViewController {

    @IBOutlet var numericScoreLabel: UILabel!
    @IBOutlet var donutView: DonutView!
    @IBOutlet var introLabel: UILabel!
    @IBOutlet var outtroLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // Fine to use Implicity unwrapped optional here, as it's loaded in lifecycle of VC
    private var presenter: ScorePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1:1 Relationship with VC and Presenter
        presenter = ScorePresenter(view: self)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        introLabel.text = "scoreview.loading".localized
        presenter.loadScoreData()
    }

}

// MARK: - Implement ScorePresenterView in an extension for clarity
extension ScoreViewController: ScorePresenterView {
    
    func present(scoreData: ScoreViewModel) {
        numericScoreLabel.text = "\(scoreData.score)"
        let lowerLabelFormat = "scoreview.score.outtro".localized
        outtroLabel.text = String(format: lowerLabelFormat, "\(scoreData.maxScore)")
        introLabel.text = "scoreview.score.intro".localized
        donutView.percent = scoreData.scorePercent
    }
    
    func present(error: ClearScoreError) {
        let title = "error.general.title".localized
        let message = error.description
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "ok".localized , style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentLoading() {
        activityIndicator.startAnimating()
    }
    
    func dismissLoading() {
        activityIndicator.stopAnimating()
    }
}
