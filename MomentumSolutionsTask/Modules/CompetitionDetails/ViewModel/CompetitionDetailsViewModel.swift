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
    let isCacheEmpty = PublishRelay<Bool>()

    func fetchCompetitionDetails(competitionId: Int) {
        FootballAPI.shared.fetchCompetitionDetails(competitionId: competitionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] matchDetails in
                print("Fetched competition details: \(matchDetails)")
                self?.matches.accept(matchDetails)
                print("Saving competition details to cache for competitionId: \(competitionId)")
                Caching.shared.saveCompetitionDetailsToCache(matchDetails, for: competitionId)
                self?.isCacheEmpty.accept(false)
            }, onError: { [weak self] error in
                print("Error fetching competition details: \(error)")
                if let cachedMatchDetails = Caching.shared.loadCompetitionDetailsFromCache(competitionId: competitionId) {
                    self?.matches.accept(cachedMatchDetails)
                    print("Loaded competition details from cache for competitionId: \(competitionId)")
                    self?.isCacheEmpty.accept(false)
                } else {
                    print("No cached competition details available for competitionId: \(competitionId)")
                    self?.isCacheEmpty.accept(true)
                }
            })
            .disposed(by: disposeBag)
        
    }
}
