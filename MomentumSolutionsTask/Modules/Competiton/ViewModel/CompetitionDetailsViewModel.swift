//
//  CompetitionDetailsViewModel.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import Foundation
import RxSwift
import RxCocoa

class CompetitionDetailsViewModel {
    private let disposeBag = DisposeBag()
    let matches = BehaviorRelay<[Match]>(value: [])

    func fetchCompetitionDetails(competitionId: Int) {
        FootballAPI.shared.fetchCompetitionDetails(competitionId: competitionId)
            .subscribe(onNext: { matches in
                self.matches.accept(matches)
            }, onError: { error in
                print("Error fetching competition details: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
