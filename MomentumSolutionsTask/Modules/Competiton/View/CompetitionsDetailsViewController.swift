//
//  CompetitionsDetailsViewController.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import UIKit
import RxSwift

class CompetitionsDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var competitionId: Int?
    private let viewModel = CompetitionDetailsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.matches
            .subscribe(onNext: { matches in
                print("Matches received: \(matches)")
            }, onError: { error in
                print("Error: \(error)")
            }).disposed(by: disposeBag)
        setupBindings()
        if let id = competitionId {
            viewModel.fetchCompetitionDetails(competitionId: id)
        }
    }
    private func setupBindings() {
        viewModel.matches.bind(to: tableView.rx.items(cellIdentifier: "MatchCell")) { index, match, cell in
            let homeTeamName = match.homeTeam?.name
            let awayTeamName = match.awayTeam?.name
            cell.textLabel?.text = "\(homeTeamName) vs \(awayTeamName)"
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Match.self)
            .subscribe(onNext: { [weak self] match in
                let matchDetailsVC = MatchDetailsViewController()
                matchDetailsVC.matchId = match.id
                self?.navigationController?.pushViewController(matchDetailsVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
