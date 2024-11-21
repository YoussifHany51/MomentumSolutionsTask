//
//  Caching.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 21/11/2024.
//

import Foundation

class Caching{
    static let shared = Caching()
    
    func saveCompetitionsToCache(_ competitions: [Competition]) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(competitions) {
            defaults.set(encoded, forKey: "competitions")
        }
    }

    func loadCompetitionsFromCache() -> [Competition]? {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "competitions") as? Data {
            if let decoded = try? JSONDecoder().decode([Competition].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
    func saveMatchDetailsToCache(_ matchDetails: MatchDetails) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(matchDetails) {
            defaults.set(encoded, forKey: "MatchDetails")
        }
    }

    func loadMatchDetailsFromCache() -> MatchDetails? {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "MatchDetails") as? Data {
            if let decoded = try? JSONDecoder().decode(MatchDetails.self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
    func saveCompetitionDetailsToCache(_ matchDetails: [MatchDetails]) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(matchDetails) {
            defaults.set(encoded, forKey: "CompetitionDetails")
        }
    }

    func loadCompetitionDetailsFromCache() -> [MatchDetails]? {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "CompetitionDetails") as? Data {
            if let decoded = try? JSONDecoder().decode([MatchDetails].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }

}
