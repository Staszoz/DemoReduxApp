//
//  RidersOfTeamState.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation

enum RidersOfTeamState {
    case didSelect(Team)
    case riders(Team, [Rider])
    case error(String)
    
    static let initial = RidersOfTeamState.riders(Team.empty, [])
}

func reduce(_ state: RidersOfTeamState, with action: Action) -> RidersOfTeamState {
    switch action {
    case let action as CompletedLoadRidersOfTeam:
        return RidersOfTeamState.riders(action.team, action.response.items.filter { $0.teamUid == action.team.uid } )
    case let action as BeginLoadingRidersOfTeam:
        return RidersOfTeamState.didSelect(action.team)
    case let action as FailLoadingRidersOfTeam:
        return RidersOfTeamState.error(action.reason)
    default: return state
    }
}
