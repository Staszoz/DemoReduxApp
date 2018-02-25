//
//  TeamsResponse.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation

struct TeamsResponse: Codable {
    let items: [Team]
}

struct RidersOfTeamResponse: Codable {
    let items: [Rider]
}


