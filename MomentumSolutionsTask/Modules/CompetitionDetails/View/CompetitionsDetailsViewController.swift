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
        tableView.register(UINib(nibName: "CompetitionsDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitonsDetailsCell")
        tableView.rowHeight = 120
        setupBindings()
        if let id = competitionId {
            viewModel.fetchCompetitionDetails(competitionId: id)
        }
    }
    private func setupBindings() {
        viewModel.matches.bind(to: tableView.rx.items(cellIdentifier: "CompetitonsDetailsCell",cellType: CompetitionsDetailsTableViewCell.self)) { index, match, cell in
            cell.homeNameLabel.text = match.homeTeam?.name
            cell.homeShortLabel.text = match.homeTeam?.shortName
            cell.awayTeamLabel.text = match.awayTeam?.name
            cell.awayShortLabel.text = match.awayTeam?.shortName
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MatchDetails.self)
            .subscribe(onNext: { [weak self] match in
                let matchDetailsVC = self?.storyboard?.instantiateViewController(withIdentifier: "MatchDetailsViewController") as! MatchDetailsViewController
                matchDetailsVC.matchId = match.id
                self?.navigationController?.pushViewController(matchDetailsVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.isCacheEmpty
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isCacheEmpty in
                if isCacheEmpty {
                    self?.showNoCacheAlert()
                }
            })
            .disposed(by: disposeBag)
    }
                      
    private func showNoCacheAlert() {
        let alert = UIAlertController(title: "No Cached Data", message: "No cached competition details are available. Please connect to the internet to fetch data.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
