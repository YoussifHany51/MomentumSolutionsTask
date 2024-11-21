//
//  CompetitionsViewModel.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import Foundation
import RxSwift
import RxCocoa

class CompetitionsViewModel {
    private let disposeBag = DisposeBag()
    let competitions = BehaviorRelay<[Competition]>(value: [])

    func fetchCompetitions() {
        FootballAPI.shared.fetchCompetitions()
            .subscribe(onNext: { [weak self] competitions in
                self?.competitions.accept(competitions)
                competitions.forEach { competition in
                    Caching.shared.saveCompetitionToCache(competition)
                }
            }, onError: { [weak self] error in
                print("Error fetching competitions: \(error)")
                if let cachedCompetitions = Caching.shared.loadCompetitionsFromCache() {
                    self?.competitions.accept(cachedCompetitions)
                    print("Loaded competitions from cache")
                } else {
                    print("No cached competitions available")
                }
            })
            .disposed(by: disposeBag)
    }
}
