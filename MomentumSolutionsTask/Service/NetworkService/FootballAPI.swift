//
//  FootballAPI.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import Foundation
import RxSwift

class FootballAPI {
    static let shared = FootballAPI()
    private let apiKey = "ad51403b3b084c10a6fcba1f7425b5df"
    
    // MARK: - Helper function to create requests
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        return request
    }
    
    // MARK: - Fetch Competitions
    func fetchCompetitions() -> Observable<[Competition]> {
        let url = URL(string: "https://api.football-data.org/v4/competitions")!
           
           return Observable.create { observer in
               let task = URLSession.shared.dataTask(with: self.createRequest(url: url)) { data, response, error in
                   if let error = error {
                       observer.onError(error)
                       return
                   }
                   guard let data = data else {
                       observer.onError(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                       return
                   }
                   if let jsonString = String(data: data, encoding: .utf8) {
                       print("API Response: \(jsonString)") // This will print the raw response
                   }
                   do {
                       let competitionsResponse = try JSONDecoder().decode(CompetitionsResponse.self, from: data)
                       if let competitions = competitionsResponse.competitions {
                           observer.onNext(competitions)
                       } else {
                           observer.onError(NSError(domain: "DecodingError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to decode competitions"]))
                       }
                   } catch {
                       observer.onError(error)
                   }
                   
                   observer.onCompleted()
               }
               task.resume()
               return Disposables.create { task.cancel() }
           }
    }

    
    // MARK: - Fetch Competition Details (Matches of a Competition)
    func fetchCompetitionDetails(competitionId: Int) -> Observable<[Match]> {
        let url = URL(string: "https://api.football-data.org/v4/competitions/\(competitionId)/matches")!
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: self.createRequest(url: url)) { data, response, error in
                
                // Handle errors
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                // Decode the matches response
                do {
                    let matchesResponse = try JSONDecoder().decode(MatchesResponse.self, from: data)
                    observer.onNext(matchesResponse.matches)
                } catch {
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    // MARK: - Fetch Match Details (Specific match information)
    func fetchMatchDetails(matchId: Int) -> Observable<MatchDetails> {
        let url = URL(string: "https://api.football-data.org/v4/matches/\(matchId)")!
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: self.createRequest(url: url)) { data, response, error in
                
                // Handle errors
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                // Decode match details response
                do {
                    let matchDetails = try JSONDecoder().decode(MatchDetails.self, from: data)
                    observer.onNext(matchDetails)
                } catch {
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
