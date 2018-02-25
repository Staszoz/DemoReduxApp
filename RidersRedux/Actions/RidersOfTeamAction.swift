//
//  RidersOfTeamAction.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation

struct CompletedLoadRidersOfTeam: Action {
    let team: Team
    let response: RidersOfTeamResponse
}
struct BeginLoadingRidersOfTeam: Action {
    let team: Team
}
struct FailLoadingRidersOfTeam: Action {
    let reason: String
}
