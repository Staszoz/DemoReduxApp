//
//  TeamListState.swift
//  RidersRedux
//
//  Created by Станислав Калиберов on 25.02.2018.
//  Copyright © 2018 Станислав Калиберов. All rights reserved.
//

import Foundation

enum TeamListState {
    case none
    case teams([Team])
    case error(String)
    
    static let initial = TeamListState.teams([])
}

func reduce(_ state: TeamListState, with action: Action) -> TeamListState {
    switch action {
    case let action as CompletedLoadTeams:
        return TeamListState.teams(action.response.items)
    case is BeginLoadingTeam:
        return TeamListState.none
    case let action as FailLoadingTeam:
        return TeamListState.error(action.reason)
    default: return state
    }
}
