//
//  MatchDetailsViewController.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import UIKit
import RxSwift

class MatchDetailsViewController: UIViewController {
    var matchId: Int?
    private let viewModel = MatchDetailsViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var homeShortName: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var awayShortName: UILabel!
    
    @IBOutlet weak var competitionLabel: UILabel!
    
    @IBOutlet weak var stageLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var homeName: UILabel!
    
    @IBOutlet weak var awayFullName: UILabel!
    
    @IBOutlet weak var refName: UILabel!
    
    @IBOutlet weak var refNationality: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Match Details"
        setupBindings()
        if let id = matchId {
            viewModel.fetchMatchDetails(matchId: id)
        }
        
    }
    private func setupBindings() {
        viewModel.matchDetails
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] details in
                print(details)
                self?.homeName.text = details.homeTeam?.name
                self?.awayFullName.text = details.awayTeam?.name
                self?.awayShortName.text = details.awayTeam?.shortName
                self?.homeShortName.text = details.homeTeam?.shortName
                self?.competitionLabel.text = details.competition?.name
                self?.dateLabel.text = details.utcDate
                self?.stageLabel.text = details.stage
                self?.statusLabel.text = details.status
                self?.refName.text = details.referees?.first?.name
                self?.refNationality.text = details.referees?.first?.nationality
            })
            .disposed(by: disposeBag)
    }

}
