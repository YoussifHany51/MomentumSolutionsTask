//
//  Match.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import Foundation


struct MatchesResponse: Codable {
    let matches: [MatchDetails]
}

struct MatchDetails: Codable {
    let id: Int
    let status: String?
    let utcDate: String?
    let competition: Competition?
    let venue: Venue?
    let stage: String?
    let group: String?
    let referees: [Referee]? 
    let homeTeam: Team?
    let awayTeam: Team?
    let score: Score?

    struct Team: Codable {
        let name: String?
        let shortName: String?
    }

    struct Score: Codable {
        let fullTime: Result
    }
    struct Result: Codable {
        let homeTeam: Int?
        let awayTeam: Int?
    }

    struct Competition: Codable {
        let name: String?
        let area: Area?
    }
    struct Area: Codable {
        let name: String?
    }

    struct Venue: Codable {
        let name: String?
        let city: String?
    }

    struct Referee: Codable {
        let name: String?
        let nationality: String?
    }
}
