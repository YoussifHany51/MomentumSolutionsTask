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
            .subscribe(onNext: { competitions in
                self.competitions.accept(competitions)
            }, onError: { error in
                print("Error fetching competitions: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
