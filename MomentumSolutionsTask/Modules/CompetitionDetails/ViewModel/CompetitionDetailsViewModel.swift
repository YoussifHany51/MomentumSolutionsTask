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
    let matches = BehaviorRelay<[MatchDetails]>(value: [])

    func fetchCompetitionDetails(competitionId: Int) {
        FootballAPI.shared.fetchCompetitionDetails(competitionId: competitionId)
            .subscribe(onNext: { matches in
                self.matches.accept(matches)
                Caching.shared.saveCompetitionDetailsToCache(matches)
            }, onError: { error in
                print("Error fetching competition details: \(error)")
                if let cachedMatchDetails = Caching.shared.loadCompetitionDetailsFromCache() {
                    self.matches.accept(cachedMatchDetails)
                    print("Loaded competition Details from cache")
                } else {
                    print("No cached competition Details available")
                }
            })
            .disposed(by: disposeBag)
    }
}
