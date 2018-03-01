//
//  ViewController.swift
//  CSExample
//
//  Created by David Casserly on 26/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import UIKit

final class ScoreViewController: UIViewController  {

    @IBOutlet var numericScoreLabel: UILabel!
    @IBOutlet var donutView: DonutView!
    @IBOutlet var introLabel: UILabel!
    @IBOutlet var outtroLabel: UILabel!
    
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
        
        
        // Loads the score data on view load. There are various other scenarios you might want to cover, such as pull to refresh, reloading automatically after network reachability changes, manual retries after errors via the UIAlertController. 
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
    
}
