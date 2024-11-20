//
//  CompetitionsViewController.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import UIKit
import RxSwift

class CompetitionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = CompetitionsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Competitions"
        tableView.register(UINib(nibName: "CompetitionsTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitionsCell")
        tableView.rowHeight = 120
        setupBindings()
        viewModel.fetchCompetitions()
    }
    
    private func setupBindings() {
        viewModel.competitions
            .bind(to: tableView.rx.items(cellIdentifier: "CompetitionsCell", cellType: CompetitionsTableViewCell.self)) { index, model, cell in
                cell.codeLabel.text = model.code
                cell.nameLabel.text = model.name
                cell.avaiSeasonLabel.text = "Available Seasons: \(model.numberOfAvailableSeasons)"
                cell.currMatchDayLabel.text = "Match Day: \(model.currentSeason?.currentMatchday ?? 0)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Competition.self)
            .subscribe(onNext: { [weak self] competition in
                guard let strongSelf = self else { return }
                
                if let indexPath = strongSelf.tableView.indexPathForSelectedRow {
                    strongSelf.tableView.deselectRow(at: indexPath, animated: true)
                }
                
                let detailsVC = strongSelf.storyboard?.instantiateViewController(withIdentifier: "CompetitionsDetailsViewController") as! CompetitionsDetailsViewController
                detailsVC.competitionId = competition.id
                strongSelf.navigationController?.pushViewController(detailsVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
