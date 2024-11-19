//
//  Competiton.swift
//  MomentumSolutionsTask
//
//  Created by Youssif Hany on 19/11/2024.
//

import Foundation

struct CompetitionsResponse: Codable {
    let competitions: [Competition]?
}

struct Competition: Codable {
    let id: Int
    let name: String
    let code: String?
    let area: Area
    let currentSeason: Season?
    let seasons: [Season]?
}

struct Area: Codable {
    let id: Int
    let name: String
}

struct Season: Codable {
    let id: Int
    let startDate: String
    let endDate: String
    let currentMatchday: Int?
}

