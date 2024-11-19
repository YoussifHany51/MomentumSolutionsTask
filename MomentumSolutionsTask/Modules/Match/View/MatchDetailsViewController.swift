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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        if let id = matchId {
            viewModel.fetchMatchDetails(matchId: id)
        }
        
    }
    private func setupBindings() {
        viewModel.matchDetails.subscribe(onNext: { [weak self] details in
            guard details != nil else { return }
        }).disposed(by: disposeBag)
    }

}
