//
//  TargetType+BreakingBadTargetType.swift
//  BreakingBad
//
//  Created by dhruvik.rao on 21/07/2021.
//

import Foundation

public let APIhostName = "breakingbadapi.com"

protocol BreakingBadTargetType: TargetType { }

extension BreakingBadTargetType {
    var hostname: String {
        return APIhostName
    }

    var baseURL: URL {
        return URL(string: "https://\(hostname)")!
    }
}
