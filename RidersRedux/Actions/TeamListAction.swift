//
//  TeamListAction.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation

struct CompletedLoadTeams: Action {
    let response: TeamsResponse
}
struct BeginLoadingTeam: Action {}
struct FailLoadingTeam: Action {
    let reason: String
}
