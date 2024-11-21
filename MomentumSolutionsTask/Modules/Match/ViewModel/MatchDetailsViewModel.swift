//
//  MatchDetailsViewModel.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import Foundation
import RxSwift
import RxCocoa

class MatchDetailsViewModel {
    private let disposeBag = DisposeBag()
    let matchDetails = BehaviorRelay<MatchDetails?>(value: nil)

    func fetchMatchDetails(matchId: Int) {
        FootballAPI.shared.fetchMatchDetails(matchId: matchId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] details in
                self?.matchDetails.accept(details)
                Caching.shared.saveMatchDetailsToCache(details)
            }, onError: { error in
                print("Error fetching match details: \(error)")
                if let cachedMatchDetails = Caching.shared.loadMatchDetailsFromCache() {
                    self.matchDetails.accept(cachedMatchDetails)
                    print("Loaded match Details from cache")
                } else {
                    print("No cached match Details available")
                }
            })
            .disposed(by: disposeBag)
    }
}
