//
//  Caching.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 21/11/2024.
//

import Foundation

class Caching {
    static let shared = Caching()
    
    // Save multiple competitions
    func saveCompetitionsToCache(_ competitions: [Competition]) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(competitions) {
            defaults.set(encoded, forKey: "competitions")
            print("Saved competitions to cache with key: competitions") // Log to confirm
        } else {
            print("Failed to encode competitions")
        }
    }

    // Save a specific competition to cache
    func saveCompetitionToCache(_ competition: Competition) {
        let defaults = UserDefaults.standard
        let cacheKey = "competition_\(competition.id)"
        if let encoded = try? JSONEncoder().encode(competition) {
            defaults.set(encoded, forKey: cacheKey)
            print("Saved competition to cache with key: \(cacheKey)")
        } else {
            print("Failed to encode competition")
        }
    }
    
    // Load a specific competition from cache
    func loadCompetitionFromCache(competitionId: Int) -> Competition? {
        let defaults = UserDefaults.standard
        let cacheKey = "competition_\(competitionId)"
        if let savedData = defaults.data(forKey: cacheKey) {
            if let decoded = try? JSONDecoder().decode(Competition.self, from: savedData) {
                return decoded
            } else {
                print("Failed to decode competition for key: \(cacheKey)")
            }
        } else {
            print("No data found in cache for key: \(cacheKey)")
        }
        return nil
    }
    
    // Load all competitions from cache
    func loadCompetitionsFromCache() -> [Competition]? {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: "competitions") {
            if let decoded = try? JSONDecoder().decode([Competition].self, from: savedData) {
                return decoded
            } else {
                print("Failed to decode competitions")
            }
        } else {
            print("No competitions found in cache")
        }
        return nil
    }

    // Save a specific match's details to cache
    func saveMatchDetailsToCache(_ matchDetails: MatchDetails) {
        let defaults = UserDefaults.standard
        let cacheKey = "matchDetails_\(matchDetails.id)"
        if let encoded = try? JSONEncoder().encode(matchDetails) {
            defaults.set(encoded, forKey: cacheKey)
            print("Saved match details to cache with key: \(cacheKey)")
        } else {
            print("Failed to encode match details")
        }
    }

    // Load a specific match's details from cache
    func loadMatchDetailsFromCache(matchId: Int) -> MatchDetails? {
        let defaults = UserDefaults.standard
        let cacheKey = "matchDetails_\(matchId)"
        if let savedData = defaults.data(forKey: cacheKey) {
            if let decoded = try? JSONDecoder().decode(MatchDetails.self, from: savedData) {
                return decoded
            } else {
                print("Failed to decode match details for key: \(cacheKey)")
            }
        } else {
            print("No data found in cache for key: \(cacheKey)")
        }
        return nil
    }

    // Save competition details (multiple match details)
    func saveCompetitionDetailsToCache(_ matchDetails: [MatchDetails], for competitionId: Int) {
        print("Saving competition details for competitionId: \(competitionId)")
           let key = "competitionDetails_\(competitionId)"
           do {
               let data = try JSONEncoder().encode(matchDetails)
               UserDefaults.standard.set(data, forKey: key)
           } catch {
               print("Failed to encode and save competition details: \(error)")
           }
       }

       func loadCompetitionDetailsFromCache(competitionId: Int) -> [MatchDetails]? {
           let key = "competitionDetails_\(competitionId)"
           guard let data = UserDefaults.standard.data(forKey: key) else {
               return nil
           }

           do {
               let matchDetails = try JSONDecoder().decode([MatchDetails].self, from: data)
               return matchDetails
           } catch {
               print("Failed to decode competition details from cache: \(error)")
               return nil
           }
       }
}

    
