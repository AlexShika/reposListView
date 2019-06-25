//
//  Repos.swift
//  ReposListView
//
//  Created by Alexandru Dinu on 25/06/2019.
//  Copyright © 2019 noname. All rights reserved.
//

import Foundation

struct Repos: Codable {
    let id: Int
    let name: String
    let owner: User
}

extension Repos {
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case name = "full_name"
    }
}
