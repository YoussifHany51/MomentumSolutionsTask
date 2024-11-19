//
//  Match.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import Foundation


struct MatchesResponse: Codable {
    let matches: [Match]
}

struct Match: Codable {
    let id: Int?
    let status: String?
    let homeTeam: Team?
    let awayTeam: Team?
}

struct Team: Codable {
    let name: String
    let shortName: String
}

struct MatchDetails: Codable {
    let score: Score
}

struct Score: Codable {
    let fullTime: Result
}

struct Result: Codable {
    let homeTeam: Int?
    let awayTeam: Int?
}
