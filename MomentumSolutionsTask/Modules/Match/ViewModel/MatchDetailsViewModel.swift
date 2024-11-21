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
            }, onError: { error in
                print("Error fetching match details: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
