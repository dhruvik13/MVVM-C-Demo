//
//  Characters.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

typealias Characters = [Character]

// MARK: - Character
struct Character: Codable, Equatable {
    let charID: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: Status
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String // "Better Call Saul" ,  "Breaking Bad" , "Breaking Bad, Better Call Saul"
    let betterCallSaulAppearance: [Int]

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }
        
    enum Status: String, Codable {
        case alive = "Alive"
        case deceased = "Deceased"
        case presumedDead = "Presumed dead"
        case unknown = "Unknown"
    }
}
