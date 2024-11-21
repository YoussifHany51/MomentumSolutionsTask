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
    
    @IBOutlet weak var venueLabel: UILabel!
    
    @IBOutlet weak var homeImg: UIImageView!
    
    @IBOutlet weak var awayImg: UIImageView!
    
    @IBOutlet weak var homeScoreLabel: UILabel!
    
    @IBOutlet weak var matchDayLabel: UILabel!
    
    @IBOutlet weak var awayScoreLabel: UILabel!
    
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
                self?.venueLabel.text = details.venue?.name
                self?.matchDayLabel.text = "MD:\(details.matchday ?? 0)"
                self?.homeScoreLabel.text = "\(details.score?.fullTime.home ?? 0)"
                self?.awayScoreLabel.text = "\(details.score?.fullTime.away ?? 0)"
                self?.awayImg.loadImage(from: details.awayTeam?.crest)
                self?.homeImg.loadImage(from: details.homeTeam?.crest)
            })
            .disposed(by: disposeBag)
    }

}
extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        // Download image data asynchronously
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
